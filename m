Return-Path: <SRS0=BUZT=I2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B37C433C1
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 28 Mar 2021 14:49:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E82F66196C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 28 Mar 2021 14:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82F66196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lQWjE-0004LA-Q2; Sun, 28 Mar 2021 14:49:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <andrealmeid@collabora.com>) id 1lQWef-0003eT-Di
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Mar 2021 14:44:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8GaxDh5r+LGyk9Emuy0QcpogzgPsqvm+OHJAD0Wb2F4=; b=m0nkCfMI+R2qVSGj9HIIpJycjX
 Z4dg6+8NLoayggCU6VtChOUAnr6MANbTZbEl1vu9idD34fqVzijpszr0miwq8AdAJcZC6IuG+JS/t
 I9ByoLBXe3Uj9ppdaRsAahtWVPhQCGxbeX1YS+HwfI3VBENPApec7foI02SI+fEDyd+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8GaxDh5r+LGyk9Emuy0QcpogzgPsqvm+OHJAD0Wb2F4=; b=koZTeyZYgcEHXbxb2jKs96P5++
 IcFTRWR6koOBS3mWlGV3f+NWIrDxGtke9tn4XMCG/kwvB8ZTXiQX2zkR7XQr0M+CHOg3L67flp5rs
 lLEq+IHko3OBVJRD0rHp6zELJpOZ8SuLRLSz0dmq58crccTgIZ/ceN19H62814WTuhBM=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lQWed-004h9a-Gg
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Mar 2021 14:44:41 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: tonyk) with ESMTPSA id CED981F46335
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Date: Sun, 28 Mar 2021 11:43:56 -0300
Message-Id: <20210328144356.12866-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210328144356.12866-1-andrealmeid@collabora.com>
References: <20210328144356.12866-1-andrealmeid@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1lQWed-004h9a-Gg
Subject: [f2fs-dev] [PATCH 3/3] f2fs: Prevent dangling dentries on casefold
 directories
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
Cc: kernel@collabora.com, Daniel Rosenberg <drosen@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 krisman@collabora.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

QmVmb3JlIG1ha2luZyBhIGZvbGRlciBhIGNhc2UtaW5zZW5zaXRpdmUgb25lLCB0aGlzIGZvbGRl
ciBjb3VsZCBoYXZlCmJlZW4gdXNlZCBiZWZvcmUgYW5kIGNyZWF0ZWQgc29tZSBuZWdhdGl2ZSBk
ZW50cmllcyAoZ2l2ZW4gdGhhdCB0aGUKZm9sZGVyIG5lZWRzIHRvIGJlIGVtcHR5IGJlZm9yZSBt
YWtpbmcgaXQgY2FzZS1pbnNlbnNpdGl2ZSwgYWxsIGRldHJpZXMKdGhlcmUgYXJlIG5lZ2F0aXZl
IG9uZXMpLiBEdXJpbmcgYSBuZXcgZmlsZSBjcmVhdGlvbiwgaWYgYSBkX2hhc2goKQpjb2xsaXNp
b24gaGFwcGVucyBhbmQgdGhlIG5hbWUgbWF0Y2hlcyBhIG5lZ2F0aXZlIGRlbnRyeSwgdGhlIG5l
dyBmaWxlCm1pZ2h0IGhhdmUgYSBuYW1lIGRpZmZlcmVudCB0aGFuIHRoZSBzcGVjaWZpZWQgYnkg
dXNlci4KClRvIHByZXZlbnQgdGhpcyBmcm9tIGhhcHBlbmluZywgcmVtb3ZlIGFsbCBuZWdhdGl2
ZSBkZW50cmllcyBpbiBhCmRpcmVjdG9yeSBiZWZvcmUgbWFraW5nIGl0IGEgY2FzZS1mb2xkZWQg
b25lLgoKRml4ZXM6IDJjMmViN2EzMDBjZCAoImYyZnM6IFN1cHBvcnQgY2FzZS1pbnNlbnNpdGl2
ZSBmaWxlIG5hbWUgbG9va3VwcyIpClNpZ25lZC1vZmYtYnk6IEFuZHLDqSBBbG1laWRhIDxhbmRy
ZWFsbWVpZEBjb2xsYWJvcmEuY29tPgotLS0KIGZzL2YyZnMvZmlsZS5jIHwgNCArKysrCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvZjJmcy9maWxlLmMg
Yi9mcy9mMmZzL2ZpbGUuYwppbmRleCBkMjZmZjJhZTNmNWUuLjYxNmI3ZWI0Mzc5NSAxMDA2NDQK
LS0tIGEvZnMvZjJmcy9maWxlLmMKKysrIGIvZnMvZjJmcy9maWxlLmMKQEAgLTE4MjYsNiArMTgy
NiwxMCBAQCBzdGF0aWMgaW50IGYyZnNfc2V0ZmxhZ3NfY29tbW9uKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHUzMiBpZmxhZ3MsIHUzMiBtYXNrKQogCQkJcmV0dXJuIC1FT1BOT1RTVVBQOwogCQlpZiAo
IWYyZnNfZW1wdHlfZGlyKGlub2RlKSkKIAkJCXJldHVybiAtRU5PVEVNUFRZOworCisJCWlmICgh
KG1hc2tlZF9mbGFncyAmIEYyRlNfQ0FTRUZPTERfRkwpICYmCisJCSAgICAoaWZsYWdzICYgRjJG
U19DQVNFRk9MRF9GTCkpCisJCQlkX2NsZWFyX2Rpcl9uZWdfZGVudHJpZXMoaW5vZGUpOwogCX0K
IAogCWlmIChpZmxhZ3MgJiAoRjJGU19DT01QUl9GTCB8IEYyRlNfTk9DT01QX0ZMKSkgewotLSAK
Mi4zMS4wCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2xpbnV4LWYyZnMtZGV2ZWwK
