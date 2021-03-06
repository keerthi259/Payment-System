<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : 'en'}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="message"/>
<!DOCTYPE html>
<html lang="${language}">
<head>
    <title><fmt:message key="admin.payment_info.title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <link rel="shortcut icon" href="resources/images/favicon-black.ico" type="image/x-icon">
    <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/styles.css">
    <link rel="stylesheet" href="resources/css/style_adminShowPaymentInfo.css">
</head>
<body>
<div class="main">
    <jsp:include page="template/header.jsp"/>

    <!-- Alert unableGetUserId -->
    <c:if test="${response eq 'unableGetUserId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnableGetUserIdError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unableGetPaymentId -->
    <c:if test="${response eq 'unableGetPaymentId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnableGetPaymentIdError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert unableGetPaymentByUserId -->
    <c:if test="${response eq 'unableGetPaymentByUserId'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertUnableGetPaymentByUserIdError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <!-- Alert showPaymentError -->
    <c:if test="${response eq 'showPaymentError'}">
        <div id="alert" class="alert alert-danger fade show" role="alert">
            <p><strong><fmt:message key="admin.page.failed"/></strong>
                <fmt:message key="admin.page.alertShowPaymentError"/>
            </p>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="page-content">
        <div class="row">
            <div class="col-lg-2">
                <jsp:include page="template/sidebar.jsp"/>
            </div>

            <div class="col-lg-10">
                <fmt:message key="admin.payment_info.formHeader" var="formHeader"/>
                <fmt:message key="admin.payment_info.outgoingPayment" var="outgoingPayment"/>
                <fmt:message key="admin.payment_info.incomingPayment" var="incomingPayment"/>
                <fmt:message key="admin.payment_info.senderAccountNumber" var="senderAccountNumber"/>
                <fmt:message key="admin.payment_info.recipientAccountNumber" var="recipientAccountNumber"/>
                <fmt:message key="admin.payment_info.recipientCardNumber" var="recipientCardNumber"/>
                <fmt:message key="admin.payment_info.accountOwner" var="accountOwner"/>
                <fmt:message key="admin.payment_info.cardOwner" var="cardOwner"/>
                <fmt:message key="admin.payment_info.sentFunds" var="sentFunds"/>
                <fmt:message key="admin.payment_info.receivedFunds" var="receivedFunds"/>
                <fmt:message key="admin.payment_info.recipientReceived" var="recipientReceived"/>
                <fmt:message key="admin.payment_info.conversion" var="??onversion"/>
                <fmt:message key="admin.payment_info.rate" var="rate"/>
                <fmt:message key="admin.payment_info.remained" var="remained"/>
                <fmt:message key="admin.page.success" var="success"/>
                <fmt:message key="admin.page.failed" var="failed"/>
                <fmt:message key="admin.user.morePayments" var="morePayments"/>
                <fmt:message key="admin.user.returnToUsers" var="returnToUsers"/>
                <fmt:message key="admin.attach_account.returnToUserProfile" var="returnToUserProfile"/>

                <div class="page-content container-fluid">
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="login-wrapper">
                                <div class="box">
                                    <div class="content-wrap">

                                        <h4>
                                            ${formHeader}
                                        </h4>

                                        <!-- Return to Users -->
                                        <c:if test="${response eq 'unableGetUserId'}">
                                            <div class="message-block">
                                                <span class="title-label forward-left-link-img">
                                                    <a href="/" class="float-left">
                                                        <img src="resources/images/return.png"
                                                             class="icon-return" alt=""/>
                                                            ${returnToUsers}
                                                    </a>
                                                </span>
                                            </div>
                                        </c:if>

                                        <!-- Return to User -->
                                        <c:if test="${response eq 'unableGetPaymentId' ||
                                                      response eq 'unableGetPaymentByUserId' ||
                                                      response eq 'showPaymentError'}">
                                            <div class="message-block">
                                                <span class="title-label forward-left-link-img">
                                                    <a href="?command=showUser&userId=${userId}" class="float-left">
                                                        <img src="resources/images/return.png"
                                                             class="icon-return" alt=""/>
                                                            ${returnToUserProfile}
                                                    </a>
                                                </span>
                                            </div>
                                        </c:if>

                                        <c:if test="${response ne 'unableGetUserId' &&
                                                      response ne 'unableGetPaymentId' &&
                                                      response ne 'unableGetPaymentByUserId' &&
                                                      response ne 'showPaymentError'}">

                                            <jsp:useBean id="payment" scope="request"
                                                         type="com.system.entity.Payment"/>
                                            <jsp:useBean id="senderUser" scope="request"
                                                         type="com.system.entity.User"/>

                                            <div class="col-xl-12">
                                                <div class="row justify-content-center">
                                                    <div class="col-md-12 first-detail">

                                                        <!-- Type of Payment -->
                                                        <c:choose>
                                                            <c:when test="${payment.isOutgoing}">
                                                                <span>${outgoingPayment}</span><br/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span>${incomingPayment}</span><br/>
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <!-- Date and Time  -->
                                                        <span>${payment.date}</span><br/>

                                                        <!-- Payment Condition  -->
                                                        <c:choose>
                                                            <c:when test="${payment.condition}">
                                                                <span class="text-success">
                                                                        ${success}
                                                                </span><br/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-danger">
                                                                        ${failed}
                                                                </span><br/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>

                                                    <div class="col-md-6">

                                                        <!-- Sender Account Number -->
                                                        <div>
                                                            <label class="for-form-label">
                                                                    ${senderAccountNumber}:
                                                            </label>
                                                            <input id="senderAccount" name="senderAccount"
                                                                   type="text" class="form-control"
                                                                   readonly="readonly"
                                                                   value="${payment.senderNumber}"/>
                                                            <label for="senderAccount"
                                                                   class="default-label">&nbsp;</label>
                                                        </div>

                                                        <!-- Sender Account Owner -->
                                                        <div>
                                                            <label class="for-form-label">
                                                                    ${accountOwner}:
                                                            </label>
                                                            <input id="senderAccountOwner" name="senderAccountOwner"
                                                                   type="text" class="form-control"
                                                                   readonly="readonly"
                                                                   value="${senderUser.name} ${senderUser.surname}"/>
                                                            <label for="senderAccountOwner"
                                                                   class="default-label">&nbsp;</label>
                                                        </div>
                                                    </div>

                                                    <c:choose>
                                                        <c:when test="${recipientIsAccount == true}">

                                                            <jsp:useBean id="recipientUser" scope="request"
                                                                         type="com.system.entity.User"/>

                                                            <div class="col-md-6">

                                                                <!-- Recipient Account Number -->
                                                                <div>
                                                                    <label class="for-form-label">
                                                                            ${recipientAccountNumber}:
                                                                    </label>
                                                                    <input id="recipientAccount" name="senderAccount"
                                                                           type="text" class="form-control"
                                                                           readonly="readonly"
                                                                           value="${payment.recipientNumber}"/>
                                                                    <label for="recipientAccount"
                                                                           class="default-label">&nbsp;</label>
                                                                </div>

                                                                <!-- Recipient Account Owner -->
                                                                <div>
                                                                    <label class="for-form-label">
                                                                            ${accountOwner}:
                                                                    </label>
                                                                    <input id="recipientAccountOwner"
                                                                           name="recipientAccountOwner"
                                                                           type="text" class="form-control"
                                                                           readonly="readonly"
                                                                           value="${recipientUser.name} ${recipientUser.surname}"/>
                                                                    <label for="recipientAccountOwner"
                                                                           class="default-label">&nbsp;</label>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-12 last-detail">

                                                                <!-- Outgoing and Incoming Payments -->
                                                                <c:choose>
                                                                    <c:when test="${payment.isOutgoing}">

                                                                        <!-- Sent Funds -->
                                                                        <span>
                                                                            ${sentFunds}: ${payment.senderAmount} ${payment.senderCurrency}
                                                                        </span><br/>

                                                                        <!-- Recipient Received -->
                                                                        <span>
                                                                            ${recipientReceived}: ${payment.recipientAmount} ${payment.recipientCurrency}
                                                                        </span><br/>

                                                                        <span>
                                                                            ${rate}: 1 ${payment.senderCurrency} = ${payment.exchangeRate} ${payment.recipientCurrency}
                                                                        </span><br/>

                                                                        <div style="height: 6px; margin-top: 5px; border-top: 2px solid #e9ecef;"></div>

                                                                        <!-- Remained -->
                                                                        <span>
                                                                            ${remained}: ${payment.newBalance} ${payment.senderCurrency}
                                                                        </span><br/>
                                                                    </c:when>
                                                                    <c:otherwise>

                                                                        <!-- Sent Funds -->
                                                                        <span>
                                                                            ${receivedFunds}: ${payment.senderAmount} ${payment.senderCurrency}
                                                                        </span><br/>

                                                                        <!-- Conversion Result -->
                                                                        <span>
                                                                            ${??onversion}: ${payment.recipientAmount} ${payment.recipientCurrency}
                                                                        </span><br/>

                                                                        <span>
                                                                            ${rate}: 1 ${payment.senderCurrency} = ${payment.exchangeRate} ${payment.recipientCurrency}
                                                                        </span><br/>

                                                                        <div style="height: 6px; margin-top: 5px; border-top: 2px solid #e9ecef;"></div>

                                                                        <!-- New balance -->
                                                                        <span>
                                                                            ${remained}: ${payment.newBalance} ${payment.recipientCurrency}
                                                                        </span><br/>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="col-md-6">

                                                                <!-- Recipient Card Number -->
                                                                <div>
                                                                    <label class="for-form-label">
                                                                            ${recipientCardNumber}:
                                                                    </label>
                                                                    <input id="recipientCard" name="recipientCard"
                                                                           type="text" class="form-control"
                                                                           readonly="readonly"
                                                                           value="${payment.recipientNumber}"/>
                                                                    <label for="recipientCard"
                                                                           class="default-label">&nbsp;</label>
                                                                </div>

                                                                <!-- Recipient Card Owner -->
                                                                <div>
                                                                    <label class="for-form-label">
                                                                            ${cardOwner}:
                                                                    </label>
                                                                    <input id="recipientCardOwner"
                                                                           name="recipientCardOwner"
                                                                           type="text" class="form-control"
                                                                           readonly="readonly"
                                                                           value="???"/>
                                                                    <label for="recipientCardOwner"
                                                                           class="default-label">&nbsp;</label>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-12 last-detail">

                                                                <!-- Outgoing and Incoming Payments -->
                                                                <c:choose>
                                                                    <c:when test="${payment.isOutgoing}">

                                                                        <!-- Sent Funds -->
                                                                        <span>
                                                                            ${sentFunds}: ${payment.senderAmount} ${payment.senderCurrency}
                                                                        </span><br/>

                                                                        <div style="height: 6px; margin-top: 5px; border-top: 2px solid #e9ecef;"></div>

                                                                        <!-- Remained -->
                                                                        <span>
                                                                            ${remained}: ${payment.newBalance} ${payment.senderCurrency}
                                                                        </span><br/>
                                                                    </c:when>
                                                                    <c:otherwise>

                                                                        <!-- [Received funds from the card] -->

                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <!-- More Payments -->
                                                    <div class="col-md-12">
                                                        <a href="?command=showUserPayments&userId=${userId}"
                                                           class="float-right" style="padding-top: 15px;">
                                                                ${morePayments}
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="template/footer.jsp"/>
</div>
</body>
</html>