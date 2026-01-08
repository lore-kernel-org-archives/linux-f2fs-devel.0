Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0149ED14890
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Jan 2026 02:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-ID:MIME-Version:References:In-Reply-To:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qqnRFoksG+o9KlBOyGWQ0Md9F9KiVYMnT/YPwk6/rGY=; b=mN854uUFjXcrItf9UpT+HsXK/8
	m2deTbYc7NBz3TJnvBA6NKD3obi01j3J3bcuvyL28RofT0qU+K88XSH8PyDn0BNAIUYiwH+xik+EF
	fsmnOurFu3CQwQyT0ERPHMejpKbHr2kFLBR6jZmtWmoqSPEN3nrGuyLUdoUoad36ni1A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vdfal-0004oB-1i;
	Thu, 08 Jan 2026 02:17:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1vdfaj-0004o3-97
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Jan 2026 02:17:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G5QJH8tZJEu40psEJJ0F50p78T0OEu00Xm0uEK9rwdk=; b=UbqGR5bkB1CvXKNqSlP+73XWBd
 CZ90XtX10QKR8c1ttyU4UXEWkDZwwvSKYTZF6WYVM/atorF2DIRpyLbzxHYrOiEh55LSx5LDjo7fr
 CZOMuWbpgTHWEJLTUGbbsHIGSGdUJ2O2hvMKLIJGVh58JcIlAOaRb8ewDDKZXFZw0v6Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References
 :In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G5QJH8tZJEu40psEJJ0F50p78T0OEu00Xm0uEK9rwdk=; b=IMERA/A03YkY3c/lxzolSYU6SG
 YoD5HYVSgw6/oo9alkhBtvOnmyAWEFDBvdPvzPJL5eKxbtjnjeI/T/lAIjrKtLeDmdfQC7fh/9mvb
 Ppt3n4f2Gn2A6R3vQ6q8G2z52zm4jsHW+GGBvy4Zib5x+uAn/CsbnoVR4PKcRkOXp4yY=;
Received: from m16.mail.126.com ([117.135.210.7])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vdfai-0003TR-9Y for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Jan 2026 02:17:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=G5QJH8tZJEu40psEJJ0F50p78T0OEu00Xm0uEK9rwdk=; b=U
 I3ydbLWL9oCoLdpqPtaBRRoP5+ifaKQa9EbBD1h9cuZPy1a6RTfizQC6A2M1xI/Y
 PcowTL6UL1tJwaCDOWArrX0E0MNQ/ni6KaeGxCbVWAzcjuFMGNnaV9gzt8HyB/q2
 cZyGBiVdtj1xR1Bn6ymQMv6r8tzwEov03LzrLFUXfw=
Received: from nzzhao$126.com ( [212.135.214.5] ) by
 ajax-webmail-wmsvr-41-117 (Coremail) ; Thu, 8 Jan 2026 10:17:12 +0800 (CST)
X-Originating-IP: [212.135.214.5]
Date: Thu, 8 Jan 2026 10:17:12 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Jaegeuk Kim" <jaegeuk@kernel.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <aV3OQu3ea5-DgzmT@google.com>
References: <20260105153101.152892-1-nzzhao@126.com>
 <aV3OQu3ea5-DgzmT@google.com>
X-NTES-SC: AL_Qu2dBfSYt04o5CKabOkWnE8Uj+g9Wsq2vv0m1IYbae8YoADm9C4xQk9EO0Xb/OaJDgOruwWmfjh/ydZfUJuN+QjRoD57VuwkemCSoLY6
MIME-Version: 1.0
Message-ID: <10088351.1d0d.19b9b64c92b.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dSkvCgD3dxOpE19pCg5BAA--.27051W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQgh8GlfE6hDOQAA3f
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Headers-End: 1vdfai-0003TR-9Y
Subject: Re: [f2fs-dev] [PATCH v1 0/5] f2fs: fix large folio read corner
 cases for immutable files
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
Cc: Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgS2ltLApBdCAyMDI2LTAxLTA3IDExOjA4OjUwLCAiSmFlZ2V1ayBLaW0iIDxqYWVnZXVrQGtl
cm5lbC5vcmc+IHdyb3RlOgo+PkhpIE5hbnpoZSwKPj4KPj5meWkgLSBJIGFwcGxpZWQgdGhlIGJl
Z2lubmluZyB0d28gcGF0Y2hlcyBmaXJzdC4KPj4KPj5UaGFua3MsCj4+CgpUaGFua3MgZm9yIGFw
cGx5aW5nIG15IHNtYWxsIGNoYW5nZXMuCgpCeSB0aGUgd2F5LCBJoa9kIGxpa2UgdG8gZGlzY3Vz
cyBvbmUgbW9yZSB0aGluZyBhYm91dCB0ZXN0aW5nIGZvciBsYXJnZSBmb2xpb3MuIApJdCBzZWVt
cyB0aGUgY3VycmVudCB4ZnN0ZXN0cyBjb3ZlcmFnZSBtYXkgbm90IGJlIHN1ZmZpY2llbnQuIFdv
dWxkIGl0IGJlIAp3ZWxjb21lIGZvciBtZSB0byBjb250cmlidXRlIHNvbWUgbmV3IHRlc3QgY2Fz
ZXMgdXBzdHJlYW0/CgpBbHNvLCBJIHRoaW5rIGxhcmdlLWZvbGlvIGZ1bmN0aW9uYWxpdHkgbWln
aHQgYWxzbyBuZWVkIGJsYWNrLWJveCB0ZXN0aW5nIHN1Y2gKYXMgZmF1bHQtaW5qZWN0aW9uLCB3
aGVyZSB3ZSBmb3JjZSBjZXJ0YWluIHBhdGhzIHRvIHJldHVybiBlcnJvcnMgYW5kIHZlcmlmeSAK
YmVoYXZpb3IgdW5kZXIgZmFpbHVyZXMuIEmhr2QgYXBwcmVjaWF0ZSB5b3VyIHRob3VnaHRzLgoK
VGhhbmtzLApOYW56aGUKCgoKCgoKCgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZz
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
