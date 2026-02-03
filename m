Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C465E83057
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=djPZ7lGTj9qFdlThzLxksHoh9rPzReaVcEWLGMtnvGI=; b=Rvx2jog/5Hndal6P5FZU7VNe+d
	QWJQ3trxJytnqWtRf87tJgzvnOjbBcFwI+dcpjraQB7K2cYcr/XuTWUAX2OD/gDKv/Sbehdj8inD+
	j+KACUCKSEH9CRzKX2jy66HDffREV72EIbs65bvE0aiFUO3/3lWMSKvIlglzyL+6yZ/c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vnAOx-00088C-0y;
	Tue, 03 Feb 2026 07:00:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vnAOl-00087y-Vq
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 07:00:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VquKc9RCIPcudh0KLo29oyeZNBYQXvLmN61pee+tYbs=; b=Z3xPczXxVkvyDsro7QAlix+hSo
 1nf9j95IaPjrCuL/5wPLjAjFBDlKCeSPnfYcR5zBNja8qNyz6lWYtX8/BHDEksICMt5rTDpCmwFRG
 sZKbZL9WFvMfJF1CsRFTsrp+uvUpwCzYxsBKQ4NZKOI+AMyR0sRD2k5fBTYqx6CAWwmc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VquKc9RCIPcudh0KLo29oyeZNBYQXvLmN61pee+tYbs=; b=Qc+5Y2rsYJEd8JIKBy7ilFvSkA
 purJ5X1XuAyKQbb1nB+AQ3+lkO3s74PxjWtbmQ4e7b370W1997p4odI24JEsYYhGpH+LT4WaL87QY
 JkbIeS4hWUR5861UTf2XCkFAiGNdxxFuv5cOsL/DLJOwOwQ3tH/Ebih33dqnzkUohgUc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vnAOl-0005HE-F1 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 07:00:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 204F6443B1;
 Tue,  3 Feb 2026 07:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24CCC116D0;
 Tue,  3 Feb 2026 07:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770102021;
 bh=7FRhymRM7ABlhFQQhv2LKLQ4s+C7K++Ywzs0GQCFyEc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=GwxmyvW1tcpbo/WXRXYO+f5eDWDRnDiSmuZ2+IS/aHGeKVRBef9d9nyCKVfb5xM2i
 gYcch6CelIa41/9imc8QrygYyN+zexNBGAsX7sCnblHu/T/Pyr8SY7/MSm/pK1ARja
 ZawB3xpk6XJPQbWDrwgbUEgUw3RSZdHKZKZ5gV/fyfqpgRVIsGvramFJC6Vr8TcHcz
 PMa1AzOqxWZCg/pPGiztH8qVJ9Epubzg4/zxKfEpjEx7O3vkh+7DSXJGOTUnZGRh4t
 SAASBnzJSv3gnUKye+FJ0LTbue5ewYcLNIzxYIOMFD+1NsbnNyeh6osTpFjxjSuY7B
 DCuaf8pH9Umvw==
Message-ID: <6458f1d3-e38e-4dbf-9202-511abb6a242e@kernel.org>
Date: Tue, 3 Feb 2026 15:00:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Barry Song <21cnbao@gmail.com>
References: <20260130132809.59707-1-chao@kernel.org>
 <CAGsJ_4yGBt4Rt=njP=cY++DbEDAWKSyDuuXOC2pXGoJGCvJYFw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGsJ_4yGBt4Rt=njP=cY++DbEDAWKSyDuuXOC2pXGoJGCvJYFw@mail.gmail.com>
X-Headers-End: 1vnAOl-0005HE-F1
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix lock priority inversion issue
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMS8zMS8yMDI2IDEwOjUwIEFNLCBCYXJyeSBTb25nIHdyb3RlOgo+IE9uIFNhdCwgSmFuIDMx
LCAyMDI2IGF0IDEwOjI34oCvQU0gQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPiB3cm90ZToKPj4K
Pj4gSWYgdXNlcnNwYWNlIHRocmVhZCBoYXMgaGVsZCBmMmZzIHJ3IHNlbWFwaG9yZSwgZHVlIHRv
IGl0cyBsb3cgcHJpb3JpdHksCj4+IGl0IGNvdWxkIGJlIHJ1bm5hYmxlIG9yIHByZWVtcHRlZCBz
dGF0ZSBmb3IgbG9uZyB0aW1lLCBkdXJpbmcgdGhlIHRpbWUsCj4+IGl0IHdpbGwgYmxvY2sgaGln
aCBwcmlvcml0eSB0aHJlYWQgd2hpY2ggaXMgdHJ5aW5nIHRvIGdyYWIgdGhlIHNhbWUgcncKPj4g
c2VtYXBob3JlLCBlLmcuIGNwX3J3c2VtLCBpb19yd3NlbS4uLgo+Pgo+PiBUbyBmaXggc3VjaCBp
c3N1ZSwgbGV0J3MgZGV0ZWN0IHRocmVhZCdzIHByaW9yaXR5IHdoZW4gaXQgdHJpZXMgdG8gZ3Jh
Ygo+PiBmMmZzX3J3c2VtIGxvY2ssIGlmIHRoZSBwcmlvcml0eSBpcyBsb3dlciB0aGFuIGEgcHJp
b3JpdHkgdGhyZXNob2xkLCBsZXQncwo+PiB1cGxpZnQgdGhlIHByaW9yaXR5IGJlZm9yZSBpdCBl
bnRlcnMgaW50byBjcml0aWNhbCByZWdpb24gb2YgbG9jaywgYW5kCj4+IHJlc3RvcmUgdGhlIHBy
aW9yaXR5IGFmdGVyIGl0IGxlYXZlcyBmcm9tIGNyaXRpY2FsIHJlZ2lvbi4KPiAKPiBIaSBDaGFv
LAo+IAo+IElzIHRoaXMgZXZlbiBwb3NzaWJsZSBpZiBjYW5fbmljZSgpIHJldHVybnMgZmFsc2Us
IGZvciBleGFtcGxlIGR1ZSB0bwo+IG1pc3NpbmcgQ0FQX1NZU19OSUNFPwoKSGkgQmFycnksCgpJ
IHRoaW5rIHNvLCB0aGUgcHJpb3JpdHkgd2lsbCBiZSB0ZW1wb3JhcmlseSB1cGxpZnRlZCBhbmQg
cmVzdG9yZWQgaW4gbG9jawpkdXJhdGlvbi4KCj4gCj4gUHJveHkgZXhlY3V0aW9uIFsxXSBpcyBj
dXJyZW50bHkgdW5kZXIgZGV2ZWxvcG1lbnQgdG8gYWRkcmVzcyBnZW5lcmFsCj4gcHJpb3JpdHkg
aW52ZXJzaW9uOyBob3BlZnVsbHksIGl0IHdpbGwgcmVzb2x2ZSB0aGlzIGlzc3VlLgoKVGhhbmtz
IGZvciBwcm92aWRpbmcgdGhlIG1hdGVyaWFsLgoKWWVzLCB0aGVyZSBzaG91bGQgYmUgZ2VuZXJp
YyBzb2x1dGlvbiBpbiBjcHUgc2NoZWR1bGVyIGFuZCBsb2NrIHByaW1pdGl2ZQp0byByZXNvbHZl
IHByaW9yaXR5IGludmVyc2lvbiBpc3N1ZS4gVGhlbiBpdCB3aWxsIGJlIGJlbmVmaXQgZm9yIGFs
bCBsb2NrCnVzZXJzLgoKTm90IHN1cmUsIGl0IHdpbGwgYmUgYSBsaXR0bGUgYml0IGhhcmQgZm9y
IHJ3IHNlbWFwaG9yZSwgaXQgbmVlZHMgdG8gdHJhY2sKYW5kIGNoZWNrIGFsbCByZWFkZXIgdGhy
ZWFkcycgY29udGV4dCBpbiBwcmlvcml0eSBpbnZlcnNpb24gc2NlbmFyaW8uCgpUaGFua3MsCgo+
IAo+IFsxXSBodHRwczovL2xwYy5ldmVudHMvZXZlbnQvMTgvY29udHJpYnV0aW9ucy8xODg3L2F0
dGFjaG1lbnRzLzE0MDIvMzA3NC9MUENfJTIwUHJveHklMjBFeGVjJTIwZGVlcCUyMGRpdmUlMjBv
dXRsaW5lLnBkZgo+IAo+IFRoYW5rcwo+IEJhcnJ5CgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Ckxp
bnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
