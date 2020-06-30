Return-Path: <SRS0=3N/Z=AL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24DBC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:09:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5BA206BE;
	Tue, 30 Jun 2020 17:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="MFzqKCZ3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Qq01d2L9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n47CiORv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5BA206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jqJlT-0000xv-Nw; Tue, 30 Jun 2020 17:09:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <rdunlap@infradead.org>) id 1jqJlS-0000xo-QX
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Jun 2020 17:09:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=leSTDW7f9bC0IBZuDJDhYDrb/Bwt22T3vmgs89G8kWU=; b=MFzqKCZ31n7Q94XyWRLXLmxTQW
 /1uMSuq0Mpjig46rkDikbCNETOezBOpipgf/aSmphnt/c+r2+4O7j1D9IMRk7exmUtndIW65inyza
 EMu9Ebm/XMZWeoeT5YZwAk0vsA44MAlleKdpWz56OXpIKNLOUuGsA5uoPylIVAGt2zDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:
 Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=leSTDW7f9bC0IBZuDJDhYDrb/Bwt22T3vmgs89G8kWU=; b=Q
 q01d2L91yQgjngmff1d9ApTflS7LRSlzZ443XIu+J6TZRpHozbt7bduqtDKb2bxNGzoMTer74K5OP
 rBDQ/eaRQZi3iHXvGZ8mJCRg70rsTbV3Dt8iPkmhBfv5ytH/ZvlhRM09OYtx1+9BNkouvlWlXTvde
 K2CW77DRuOoXtMW0=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jqJlR-007hRM-8D
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Jun 2020 17:09:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=leSTDW7f9bC0IBZuDJDhYDrb/Bwt22T3vmgs89G8kWU=; b=n47CiORvKJxT1xEVBb9TCpG5ic
 NdzLTX2tOK1wnfDaqGRrP/wtpCGnIqIvmQEUozICzBdOdAzZApaJuUGJEd2155j8WuKl9yBuTz4Bc
 xDYhHWb8FyAsl1X4ROILkUCiGJM873FzZvjsc21NJpjfufgF8pSbgKNWvmes4rdSuSv+ayWUDtRS7
 UtLU91WC2xYoBYQM24Az8TQzscWc4wEbFxuQzX/IJp8eKoO2ivWem/sb/2O5tELa2nvsLp8rqhXaD
 asU5qVPovgWNvncxGZyeo54RwrZhbLhNQ44PhF3X/FBh32MJsSCsA3XcdVO5Os02soKX8xtaxBF0c
 ioIa3IOw==;
Received: from [2601:1c0:6280:3f0::19c2]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqJl9-0003Kx-Dq; Tue, 30 Jun 2020 17:09:28 +0000
To: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
 linux-f2fs-devel@lists.sourceforge.net
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <020937f3-2947-ca41-c18a-026782216711@infradead.org>
Date: Tue, 30 Jun 2020 10:09:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Language: en-US
X-Headers-End: 1jqJlR-007hRM-8D
Subject: [f2fs-dev] [PATCH] f2fs: always expose label 'next_page'
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+CgpGaXggYnVpbGQgZXJy
b3Igd2hlbiBGMkZTX0ZTX0NPTVBSRVNTSU9OIGlzIG5vdCBzZXQvZW5hYmxlZC4KVGhpcyBsYWJl
bCBpcyBuZWVkZWQgaW4gZWl0aGVyIGNhc2UuCgouLi9mcy9mMmZzL2RhdGEuYzogSW4gZnVuY3Rp
b24g4oCYZjJmc19tcGFnZV9yZWFkcGFnZXPigJk6Ci4uL2ZzL2YyZnMvZGF0YS5jOjIzMjc6NTog
ZXJyb3I6IGxhYmVsIOKAmG5leHRfcGFnZeKAmSB1c2VkIGJ1dCBub3QgZGVmaW5lZAogICAgIGdv
dG8gbmV4dF9wYWdlOwoKU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJh
ZGVhZC5vcmc+CkNjOiBKYWVnZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3JnPgpDYzogQ2hhbyBZ
dSA8eXVjaGFvMEBodWF3ZWkuY29tPgpDYzogbGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKLS0tCiBmcy9mMmZzL2RhdGEuYyB8ICAgIDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGRlbGV0aW9ucygtKQoKLS0tIGxpbnV4LW5leHQtMjAyMDA2MzAub3JpZy9mcy9mMmZzL2RhdGEu
YworKysgbGludXgtbmV4dC0yMDIwMDYzMC9mcy9mMmZzL2RhdGEuYwpAQCAtMjM2Niw5ICsyMzY2
LDcgQEAgc2V0X2Vycm9yX3BhZ2U6CiAJCQl6ZXJvX3VzZXJfc2VnbWVudChwYWdlLCAwLCBQQUdF
X1NJWkUpOwogCQkJdW5sb2NrX3BhZ2UocGFnZSk7CiAJCX0KLSNpZmRlZiBDT05GSUdfRjJGU19G
U19DT01QUkVTU0lPTgogbmV4dF9wYWdlOgotI2VuZGlmCiAJCWlmIChyYWMpCiAJCQlwdXRfcGFn
ZShwYWdlKTsKIAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby9saW51eC1mMmZzLWRldmVsCg==
