Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50505C3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Aug 2024 08:05:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sh2oc-0001yO-DA;
	Thu, 22 Aug 2024 08:05:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jan.polasek@envisioncraftsman.com>)
 id 1sh2oa-0001y5-AD for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 08:05:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uGTmdNfeKWYppKfROrYtp0X+RK7/pRJQsBUrarqToyk=; b=THX0c5hAYQXMbrceSnoiTHnUY6
 lul902rD1dQ4E7CY/M64Qg72qSEAgE06FKvnzzldDUVqyEwhSZ/swVrYu9D3acR196q8Wo4Esv+kQ
 0k3g5QdiG8Z+6QVrYUO8H0A5y1L/1gXXLJSPEayIvQPdowVZaulnik/VGc9Iqa/7+rFg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:From:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uGTmdNfeKWYppKfROrYtp0X+RK7/pRJQsBUrarqToyk=; b=M
 Shdy7IKJ+EmZ27+neYxIEymAFtXFgGxmhw1VYsChibxfzflYEfgMTQpFfr/6LdKIDqzzmNvUrIaXH
 CqI4qJBAfqYPf/W7nvhrPI32QWHXcyTyqOcwL8/z/t4IC8RhEo+1Z2RdHBt6LSTPG8UkSn2P9HpfL
 TLCQ0NIqKrVvOv3A=;
Received: from mail.envisioncraftsman.com ([162.19.67.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sh2oZ-00035h-I9 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 08:05:04 +0000
Received: by mail.envisioncraftsman.com (Postfix, from userid 1002)
 id 241A124CFE; Thu, 22 Aug 2024 10:00:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=envisioncraftsman.com; s=mail; t=1724313705;
 bh=uGTmdNfeKWYppKfROrYtp0X+RK7/pRJQsBUrarqToyk=;
 h=Date:From:To:Subject:From;
 b=W6PINz9bIsLI8TMCb0Mk/a8zNUnngCojmLk3JFCLAmVgtPzm79ugLV0Yh4kcVG7KU
 i/QuIZ2smQitZwv72lUE9irpLe2yJ/A/ddKJE3f7cw97Yu4RBws+Fddq62boRqG4uP
 gYuJN0ha7GipL4JfnX0JLqYigcowQ/5Gz1oY6FEuKUrRchScEjzK1voqH3Dubuo+Na
 9FmtBVo1DF8afSiiqTNVgDjApYfzHK7n6MgL2vORvuLNyoGKI8wPMdnu9Nc4OVqPDP
 eekxn9ztwBxOahjVCHdQHTqNid0k9jUOChcuNrEaCM+1ZBuhUmueoCF+TkB89+4r3w
 mGnX2JWoFlxFg==
Received: by mail.envisioncraftsman.com for
 <linux-f2fs-devel@lists.sourceforge.net>; Thu, 22 Aug 2024 08:00:39 GMT
Message-ID: <20240822084500-0.1.4k.vsy4.0.s4cq70vrfe@envisioncraftsman.com>
Date: Thu, 22 Aug 2024 08:00:39 GMT
To: <linux-f2fs-devel@lists.sourceforge.net>
X-Mailer: mail.envisioncraftsman.com
MIME-Version: 1.0
X-Headers-End: 1sh2oZ-00035h-I9
Subject: [f2fs-dev] Quick Question About Collaboration
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
From: =?UTF-8?Q? Jan_Pol=C3=A1=C5=A1ek ?= via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: =?UTF-8?Q? Jan_Pol=C3=A1=C5=A1ek ?=
 <jan.polasek@envisioncraftsman.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGVsbG8hCgpJIGFtIHZlcnkgaW1wcmVzc2VkIHdpdGggdGhlIHByb2R1Y3RzIGFuZCBzZXJ2aWNl
cyB5b3Ugb2ZmZXIuCgpJIHRob3VnaHQgd2UgY291bGQgaGVscCB5b3UgcmVhY2ggYSBsYXJnZXIg
YXVkaWVuY2Ugd2l0aCB5b3VyIG9mZmVyaW5ncy4gV291bGQgeW91IGJlIGludGVyZXN0ZWQgaW4g
Y29sbGFib3JhdGluZyB3aXRoIHVzIGluIGFuIGFmZmlsaWF0ZSBtYXJrZXRpbmcgY2FtcGFpZ24/
CgpGb3IgZXhhbXBsZSwgb3VyIHByb2dyYW0gZm9yIGEgY29tcGFueSBpbiB0aGUgZS1jb21tZXJj
ZSBzZWN0b3IgcmVzdWx0ZWQgaW4gYW4gaW5jcmVhc2UgaW4gcmV2ZW51ZSBmcm9tIDglIHRvIGFu
IGltcHJlc3NpdmUgMTklIChvbiBhdmVyYWdlIHBlciBxdWFydGVyKS4KCldlIGFjaGlldmUgdXAg
dG8gMTMlIHR1cm5vdmVyIGluIEdBNCwgd2hpbGUgc3RhbmRhcmQgYWZmaWxpYXRlIG5ldHdvcmtz
IGdlbmVyYXRlIG9ubHkgMy02JS4KCldvdWxkIHlvdSBoYXZlIHRpbWUgZm9yIGEgc2hvcnQgY29u
dmVyc2F0aW9uIGluIHRoZSBuZXh0IGZldyBkYXlzPwoKCkJlc3QgcmVnYXJkcwpKYW4gUG9sw6HF
oWVrCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
