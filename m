Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0D1D5E149
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 Nov 2024 09:06:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t9Kwi-0000Vd-Q5;
	Fri, 08 Nov 2024 09:06:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jan.polasek@bytebrigadebuilders.com>)
 id 1t9Kwh-0000VX-En for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 Nov 2024 09:06:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bRQ4jFxNVcM6F4NBYTbWMLQ1h+eElp/lMiKXKTCAKAg=; b=L0SNnF+eW0/PJ8bZvSdOpJWU8w
 WZx0BvhPN4wiq0kpzDigehCUGCOXVyRUeebe4g7Ui2QXArbU8VaU9canuapGSaf6/AFl5na6VYybM
 0vGGqmFwvcCLp802aCoChq7FJyT2/EVoGmRJX4vq2n5uCBuoQND+sMRQiD4c5Me4hD3g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:From:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bRQ4jFxNVcM6F4NBYTbWMLQ1h+eElp/lMiKXKTCAKAg=; b=L
 6AsLrd26K4YVyulPcUzSo98O46wnl52X+DtMtTQMQrMF9iwk0jzLuvcnLtanSh/CG/qOVtywkRKvy
 p815jwWfj3HxiNLSrCwIuv5k8z/B4lR9jhmP4KZbvDsyps9TN4AZmhWV6QGu6FTD/RZvmazk/57aO
 QRv9lC7XyDWFF4DU=;
Received: from mail.bytebrigadebuilders.com ([80.211.239.163])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t9Kwg-0001xx-Ua for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 Nov 2024 09:06:24 +0000
Received: by mail.ByteBrigadeBuilders.com (Postfix, from userid 1002)
 id 517228467F; Fri,  8 Nov 2024 10:06:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=ByteBrigadeBuilders.com; s=mail; t=1731056771;
 bh=bRQ4jFxNVcM6F4NBYTbWMLQ1h+eElp/lMiKXKTCAKAg=;
 h=Date:From:To:Subject:From;
 b=njvdMfHUcUrZT59ktmtpXoYkPcwDQjx7IfgiocqDzGxByl22yjf1eK7r7usyqAIDi
 /tzAx4iIu9pMXfaXFgweEd5y4M7+TGNjtIeZcJeZ++XzpoPz7AAhziMgr669Yf8/CH
 N6BAi2CWi3qG+hOzQmKGuqMymjwE8iIac2jAt5fh2Q7IGMtaAWZ88e8uz0J3oRi5e1
 VzZPCJWZegfVvh4IJB9hBfkeZ9c6ESoMkRnIDzGzCE+jAU82GATlksrDa1XvXq7Hds
 QEtzQlPJvn6XseN3by24FXvASYj2tca2aAksF+i6JdJB9boknrkkUJaTF9P1WuSGSJ
 rZp/AQ9R9tj3g==
Received: by mail.ByteBrigadeBuilders.com for
 <linux-f2fs-devel@lists.sourceforge.net>; Fri,  8 Nov 2024 09:05:55 GMT
Message-ID: <20241108084500-0.1.b2.y8dk.0.nmt2iofpqv@ByteBrigadeBuilders.com>
Date: Fri,  8 Nov 2024 09:05:55 GMT
To: <linux-f2fs-devel@lists.sourceforge.net>
X-Mailer: mail.ByteBrigadeBuilders.com
MIME-Version: 1.0
X-Headers-End: 1t9Kwg-0001xx-Ua
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
From: Jan Polasek via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Polasek <jan.polasek@bytebrigadebuilders.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkhCgpJ4oCZbSByZWFjaGluZyBvdXQgYmVjYXVzZSBJIHNlZSBncmVhdCBwb3RlbnRpYWwgaW4g
eW91ciBwcm9kdWN0cyBhbmQgc2VydmljZXMuCgpJbWFnaW5lIHlvdXIgb2ZmZXIgcmVhY2hpbmcg
dGhvdXNhbmRzIG9mIG5ldywgZW5nYWdlZCBjdXN0b21lcnMuIFRoYXQncyBleGFjdGx5IHdoYXQg
d2Ugb2ZmZXIgdGhyb3VnaCBvdXIgYWZmaWxpYXRlIG1hcmtldGluZyBwcm9ncmFtLgoKT3ZlciB0
aGUgcGFzdCAzIHllYXJzLCB0aGUgYWZmaWxpYXRlIGFjdGl2aXRpZXMgd2UgY29uZHVjdGVkIGZv
ciBvbmUgb2Ygb3VyIGNsaWVudHMgaW4gdGhlIGUtY29tbWVyY2UgaW5kdXN0cnkgY29udHJpYnV0
ZWQgdG8gYW4gaW1wcmVzc2l2ZSByZXZlbnVlIGdyb3d0aCBmcm9tIDglIHRvIDE5JSAocXVhcnRl
cmx5IGF2ZXJhZ2UpLgoKV2UgaGF2ZSBleHRlbnNpdmUgZXhwZXJpZW5jZSBpbiB0aGUgQ0VFIG1h
cmtldCAoQ2VudHJhbCBhbmQgRWFzdGVybiBFdXJvcGUpLCB3aGljaCBpcyBjdXJyZW50bHkgdGhl
IGZhc3Rlc3QtZ3Jvd2luZyBhZHZlcnRpc2luZyBtYXJrZXQgaW4gdGhlIHdvcmxkLgoKV2UgYXJl
IGludGVyZXN0ZWQgaW4gcGFydG5lcmluZyB3aXRoIHdlYnNpdGVzIHRoYXQgYXR0cmFjdCBhdCBs
ZWFzdCAyMDAsMDAwIHZpc2l0cyBwZXIgbW9udGguIEhvdyBhYm91dCBhIHNob3J0LCBuby1vYmxp
Z2F0aW9uIGNvbnZlcnNhdGlvbj8KCgpCZXN0IHJlZ2FyZHMKSmFuIFBvbGFzZWsKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVs
IG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRw
czovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVs
Cg==
