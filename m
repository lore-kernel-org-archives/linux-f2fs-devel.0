Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F518C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 Apr 2022 17:30:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ngVCv-0003VQ-QY; Mon, 18 Apr 2022 17:30:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1ngVCu-0003VK-Gv
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Apr 2022 17:30:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4+8y86TzvhgYeTGpqB4Qi1dq6pLQPoBktnFkdoFERkY=; b=cSbpcxfIVy8m+xnKu2arXnuobD
 PnUwbyLju2bp/Jav733/aQ215dsrM7JpI9R3DjiJBrLVzagRK/lk2CLlFGVcztEwPW1UTkjpomdbT
 K0TnHEsfC6u4HZ/CPIMe3QniFwfQd9P39iSnZ9LBtpyhYM8ctdJRnOr+E2fI1w86f7iw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4+8y86TzvhgYeTGpqB4Qi1dq6pLQPoBktnFkdoFERkY=; b=TiGR7724oXgipZWWNl7s84q4nL
 o0RSld/5RyOyCAf2UM4JBmyr7lg1pPqMjDDC9r3XwHSQS1f7A3u9RxJaBr+C/X0SjubmoVnlnVOpV
 lpuqoZ8v1wo8n4rj2Cn9t+6dMC8x3a4HH+Vs3c0zCbhi4UBbxDff4miCEt/w4wWQzPLg=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1ngVCt-0004p9-1n
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Apr 2022 17:30:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E2C86B80E6E;
 Mon, 18 Apr 2022 17:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6684AC385A1;
 Mon, 18 Apr 2022 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650303022;
 bh=+UIzYVxyzxRT11X4z3T0x4T8DeFC/oA4RVmksBl+vv0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=onF7uV2GsHodWyQ/+IJQZK8BD7NFbinJLCI6fmiXoZBk9x0TL1qlAZwvsu0w25VTB
 zn/gBFvUDv/kycWk3vLIh2EWGUvnK1yseUqbxhlPW8e0OnRFEMIm3jLokcb1G5dNmR
 MKg52n9V9SPZd/mbPTcdNfqeWBIGsmMxNNV3IJUi1tbeX2z9Ba9tH5vHWErLbZ0k9g
 NzQswJY75XF43FbUAGQ13qkUaiN99kNEaYJ+J30lu1GtwJhQqrhwV5N7Ic4j2RVTpp
 xp/zhtmDM6itNQnvsK9C+6D5WB6ECSwbmAi7qRzugLSsLdkswKeSujtiN4zPebYqPH
 laUvcQYhl9USg==
Date: Mon, 18 Apr 2022 17:30:20 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: =?utf-8?B?5bi45Yek5qWg?= <changfengnan@vivo.com>
Message-ID: <Yl2gLG/8U9HdRpUT@gmail.com>
References: <KL1PR0601MB4003AA93745F5F9A79794BE4BBF39@KL1PR0601MB4003.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <KL1PR0601MB4003AA93745F5F9A79794BE4BBF39@KL1PR0601MB4003.apcprd06.prod.outlook.com>
X-Headers-End: 1ngVCt-0004p9-1n
Subject: Re: [f2fs-dev] f2fs compressed file bio merge problem
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

WytDYyBsaW51eC1mc2NyeXB0XQoKT24gTW9uLCBBcHIgMTgsIDIwMjIgYXQgMDg6MTU6NDdBTSAr
MDAwMCwg5bi45Yek5qWgIHdyb3RlOgo+IEhpOgo+IAlXaGVuIEkgdGVzdCBzZXEtd3JpdGUgb24g
ZjJmcyBjb21wcmVzc2VkIGZpbGUsIEkgZm91bmQgaXQgbWF5IGhhdmUgc2lnbmlmaWNhbnQgcGVy
Zm9ybWFuY2UgZGVncmFkYXRpb24gd2hlbiBtb3VudCB3aXRoIGlubGluZWNyeXB0LiBIZXJlIGlz
IG15IGFuYWx5c2lzOiAJCj4gCWYyZnMgd3JpdGUgY29tcHJlc3NlZCBmaWxlIGluIHVuaXQgb2Yg
Y2x1c3RlciwgYWZ0ZXIgY29tcHJlc3NlZCwgb25lIGNsdXN0ZXIgdXAgdG8gaGF2ZSB0aHJlZSB2
YWxpZCBwYWdlcyB0byB3cml0ZS4gU28gYmV0d2VlbiBtdWx0aSBjbHVzdGVycywgdGhlIHBhZ2Ug
aW5kZXggY291bGRuJ3QgYmUgY29udGlndW91cy4gRm9yIGV4YW1wbGUsIEl0IG1heSBsaWtlIHRo
aXM6IENsdXN0ZXIgMCB3cml0ZSBwYWdlIDAgYW5kIDEsIENsdXN0ZXIgMSB3cml0ZSBwYWdlIDQg
YW5kIDUuCj4gCUluIGYyZnNfY3J5cHRfbWVyZ2VhYmxlX2JpbywgZnNjcnlwdF9tZXJnZWFibGVf
YmlvIHdpbGwgY2hlY2sgd2VhdGhlciBmaWxlIGxvZ2ljYWwgYmxvY2sgbnVtYmVyIGlzIGNvbnRp
Z3VvdXMsIHJlc3VsdCBpbiBtdWx0aSBjbHVzdGVycyBjYW5ub3QgYmUgbWVyZ2UgaW50byBvbmUg
YmlvLgo+IAlJbiBteSB0ZXN0LCBpbmxpbmVjcnlwdCBtb3VudCBvcHRpb24gbWF5IGNhdXNlIHNl
cS13cml0ZSBwZXJmb3JtYW5jZSB0byBkcm9wIGJ5IGhhbGYuCj4gCVRoZSBhdHRhY2htZW50IGlz
IG15IGZpbyB0ZXN0IGNvbmZpZ3VyZSBmaWxlLgo+IAlUaGlzIGlzIGEgdHJpY2t5IHByb2JsZW0g
Zm9yIG1lLiBJcyB0aGVyZSBhbnkgc29sdXRpb24gZm9yIHRoaXMgcHJvYmxlbT8KClRoYW5rcyBm
b3IgY2xhcmlmeWluZyB0aGF0IHlvdSBhcmUgdXNpbmcgZjJmcyBjb21wcmVzc2lvbjsgaW4geW91
ciBwcmV2aW91cwptZXNzYWdlIHlvdSBkaWRuJ3QgbWVudGlvbiB0aGlzCihodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvS0wxUFIwNjAxTUI0MDAzOTk4Qjg0MTUxM0JDQUEzODZBREVCQkVFOUBL
TDFQUjA2MDFNQjQwMDMuYXBjcHJkMDYucHJvZC5vdXRsb29rLmNvbS9ULyN1KS4KClVuZm9ydHVu
YXRlbHksIEkgZG9uJ3QgYmVsaWV2ZSB0aGVyZSBpcyBhbnkgcHJhY3RpY2FsIHdheSB0aGF0IHdl
IGNvdWxkIGRvIHRoZQplbmNyeXB0aW9uIGRpZmZlcmVudGx5IHRoYXQgd291bGQgcmVzdWx0IGlu
IHRoaXMgbm8gbG9uZ2VyIGJlaW5nIGEgcHJvYmxlbS4KClRoaXMgaXMgYmVjYXVzZSBmb3IgYWRq
YWNlbnQgY2x1c3RlcnMgdG8gaGF2ZSBjb250aWd1b3VzIERVTnMsIHRoZSBEVU5zIHdvdWxkCmhh
dmUgdG8gaW5jcmVtZW50IGFjY29yZGluZyB0byB0aGUgY29tcHJlc3NlZCBzaXplLCBub3QgdGhl
IHVuY29tcHJlc3NlZCBzaXplLgpIb3dldmVyLCBpbiB0aGlzIGNhc2UgaXQgd291bGRuJ3QgYmUg
cG9zc2libGUgdG8gc3VwcG9ydCByYW5kb20tYWNjZXNzIHdyaXRlcywKc2luY2UgYW55IHdyaXRl
IHdvdWxkIHJlcXVpcmUgcmUtd3JpdGluZyB0aGUgZW50aXJlIGZpbGUuCgpUaGlzIGNvdWxkIGJl
IHByb3ZpZGVkIGFzIGFuIG9wdGlvbiBmb3IgcmVhZC1vbmx5IGZpbGVzeXN0ZW1zLCBJIHN1cHBv
c2UuICBCdXQgSQpkb3VidCB0aGF0IHRoYXQgaXMgeW91ciB1c2UgY2FzZS4KCi0gRXJpYwoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMt
ZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMt
ZGV2ZWwK
