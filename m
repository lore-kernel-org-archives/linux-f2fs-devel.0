Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BE6C61DCB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YntO9/eh6MBLwjIw+tFFY+18bys6avcV2B7QmX9L8F8=; b=HoiOko+qIg9b1YQVf5CSy5osjH
	g7m5AqI+uYyYQGhZ3KC0cL1Z1wmsrpqub0opeB4SUVM1aPoQp6hD+8n7VVF96+nP6ZOuacIthmfWD
	RggFGTuAvmyajjjUN9hqL+nT2FAOJ+XbW4BgotXOol3rPwndKVWkc/2AJIIaSgttl11I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x00ky-0007hZ-Pt;
	Fri, 28 Aug 2026 17:52:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x00kx-0007hQ-3v
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 17:52:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xWPpK39kkwZ7ljJh3+TEpc44Vz3uaxpuv9JHHyuPUYE=; b=LO2/L/FRed5+oBfNa1NTtTU5Om
 KKVb0a9H6SKhNkfW4WaaHBvDYdy2pGKOsB/qsEw5t3Y2A+DDDc0wT2FwmEJO49Lo0NbLE+mq/q2v1
 Mc16FO4RVsHyBNJ4nJoy1Y4Q7bN0io7ncrzfTv99JZpfxQ/dXaiF26aHv8KVAko4SrwY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xWPpK39kkwZ7ljJh3+TEpc44Vz3uaxpuv9JHHyuPUYE=; b=M2ydlVMEW2kiHDnIz8I3bcdIyY
 uPHOQtA48vG7373TRpHjrJBlRMMmjGJILHe/RfB2tmV3av7jBsrGOjiObbdAtWX7FiAYb9ogonVXX
 OveLlBdSsewopOvJYjfGHhKSxy58vVNMFv2OCQLvoCOeae+36XF9tRdfwrDDrjuuzoY4=;
Received: from mail-pf1-f173.google.com ([209.85.210.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x00kw-0004Kj-KU for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 17:52:47 +0000
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-84e27035206so1184090b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 10:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787939561; cv=none;
 d=google.com; s=arc-20260327;
 b=VNgUbfj0rzyxokiaCs00h6EYd3Ivvhss5mpIftilxK9Je1Fs+j74FCaMBDUqUUOIHY
 8z37Ms67mMPigR23Wpw7KW1M6nahCoGnDt6fDLXaY6qBwxVSWAKJ2ycMy5Pu36K7fJ6p
 /iYwVJFFMa2Ez7HiYFCVEoWXT/p9zdNA4+9+kb86IdvVUYwUYJU5sWrjf1RX8oVvXGO2
 9JgAiBaHXOmsOgD34HS9KYGMumY8uRKEvuzeNR+hRrfcLGEROWjnwdKmJqV1dRE51K1z
 wLaJwHoJdKE1nikSqBB/r1rPd7ntQ2Z4AhKvY7tVSaGC9RhcBVHVPvo0/oUV99wX3ZB4
 WI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xWPpK39kkwZ7ljJh3+TEpc44Vz3uaxpuv9JHHyuPUYE=;
 fh=o43Yx3eqP6dmVMXUucFywW81bsxsEo5VEZSrVoj77So=;
 b=Y23L5fw52oS5dxkfYTkhX325z61qtFVhuYF6LChbHLLAC8lYDVFxQCrTz8pfthJpqV
 QEud8WPMKIuhza6ILirDLcQ7uJ4aQY747xiTDEZKV5JTiMNyns2bqhtzvTsnduIiUX1n
 x9hq0xA4/nud+Whd/382W9JzQcW2RxTfAaMZFXhg8aE4W2oQT0PHZvSku67GOBeWfVkO
 dfzA6uzl9kDqmHlOU6GRWP/MfS1JUnYs+8lh7yWS6j7FXBSI/IXoruwsTzdzmT2/Sb26
 ExDR237HZoW2cTa4L1aeqdXSSv3BjdjY5Bx7wOWlyZadOsYga0gYrlaP5ll4o2jJ3ltB
 IzAA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787939561; x=1788544361; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xWPpK39kkwZ7ljJh3+TEpc44Vz3uaxpuv9JHHyuPUYE=;
 b=dwIRReuSYPClDHQflRNQ2twldqjYB3A1Wbgvl9GKZ/EJw8LqQoucxzs/ohYiQ2IFvh
 hml0BJwWmyiTSrKgc+t8baRcdWLP5eD6uztD11Oz5r40hZTwGdH5TCSasdqVW/mFHh9T
 4eIhckTQvUjdaLTgPy+JddENAvvO31kdSsprGrv8pOZeoFPYqDG/DouwmtFv29nkzKV6
 NgoP5S8ZPwATZ+6J8dR+W9d0kkhvO4z+ZBHQs6fc3+GrUS7e0m1fbBlK5Cg1rER/RrWl
 I1ErvN8SRSOMZpYLeCdFE2WT7UhoSKJCdsaTm+NJVhyAWgQsn09DF7ZIh6YYNPf6B3XJ
 tOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787939561; x=1788544361;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xWPpK39kkwZ7ljJh3+TEpc44Vz3uaxpuv9JHHyuPUYE=;
 b=sukMMMnnqRS1Nfz6PD6dUj4XYsi7IXJvlFfQyHPbqgjIgTqs7avGrzUcEDMhbg+Tzl
 mRtLBCEYIXmQE6u/5CWQ6XnR6IYSMmL6lgfHy594C/eonVGSd5k6gPPpa2wHcxr8P14E
 vVBjEqYtTMMwoPMvnhigm1mKpJwvvsMUqiek1qJCk4hdmCmaizbKwxpJGmKsEhxxB0em
 bYKBIueAXAGf/OfI+vDixdLZFmi42+b2jOqjPzL+ibPWdchxdNo7VGy8ITn5ixL4Rt6h
 Wb4Eyptmq6Hgrz6YKLsWgUQVj5arYQSkP6n6/B/5QXFQAlbzkJP7MLlxbfrTcFJo7y6q
 ck4A==
X-Gm-Message-State: AFuF++nRxUltIP1Rqr5vycV8+mTbjJf6ucJZxrjFKuPB7jdvlnhUyoms
 F+ahATjRD2dDMDyIihDq/EwO+PwzJTElvhDNNa6QW2STBqGJJ+lbT6Q6LJ5xxBEY3Jy3FYuaABu
 tw0lVeP8vBALvkDOZwrnfgjTVEptw4Lc=
X-Gm-Gg: AR+sD13CogszkszCod+0s829TjkMmXqHF7L5EuWsOqp34dglPAxHlZblKRqvt+g0684
 XZmvSTdOxvSknVkxFophV1AeQ3ZDQrxRNc/g4YGi3Lr7Q7+JvQ6W+RoxlNHoyIT3ukF8PZZPDjm
 tLItsuXr3XKOf9GVrprsowcuUAoKFbyZUGzf+dJXDzDV+oNzGk/WUn0vrp2OdXQSpSS0Vm4YwQ6
 /znfsNriIfR8x7PBqhTwyxTw9WtlasqeMPM1TN5mCaTjbEYtGen+eQTDOBqwg8VCRX/sq+uoMdG
 rbYizUibO7aQLW1dUOd/26MbVpqHDyQ92h1qW85GAyowh69z6YDSLt/HjHYH15+w0BCAtyHrWds
 7E0ozh5k6UUPpdnfSjt65fWoRynWAe0cfK55elqqSKPl0
X-Received: by 2002:a05:6a00:390c:b0:857:726d:2e9c with SMTP id
 d2e1a72fcca58-857726d301cmr1724560b3a.25.1787939560883; Fri, 28 Aug 2026
 10:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
 <20260826130916.2231342-4-zhaonanzhe@xiaomi.com>
In-Reply-To: <20260826130916.2231342-4-zhaonanzhe@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 28 Aug 2026 10:52:21 -0700
X-Gm-Features: AcwNN1WUBDd6efZN5XHqxY9lyShZYtca5PE80NEUuVrxcs3NfoRFFB6LUMG3fQA
Message-ID: <CACOAw_xyveu1Dt-UwWFKtEtf0LOZn2TOwqNyXh_DKRs=gCVY9A@mail.gmail.com>
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
X-Headers-End: 1x00kw-0004Kj-KU
Subject: Re: [f2fs-dev] [PATCH 14/14] f2fs: make compressed files compatible
 with large folio
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
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <nzzhao@126.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBBdWcgMjYsIDIwMjYgYXQgODoxMOKAr0FNIE5hbnpoZSBaaGFvIHZpYSBMaW51eC1m
MmZzLWRldmVsCjxsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldD4gd3JvdGU6
Cj4KPiBUaGUgY29tcHJlc3Npb24gZmxhZyBpcyB0aGUgaGludCBpbmRpY2F0ZXMgdGhhdCB0aGUg
aW5vZGUgY2FuIGJlCj4gY29tcHJlc3NlZCwgd2hlbiB0aGUgaW5vZGUgaXMgdXNpbmcgbGFyZ2Ug
Zm9saW8sIHdlIGV4cGVjdGVkIGl0IGtlZXBzCj4gdXNpbmcgdGhlIGxhcmdlIGZvbGlvIHJlYWQv
d3JpdGUgcGF0aHMgYW5kIGl0cyBkYXRhIHN0YXlzIHVuY29tcHJlc3NlZAo+IG9uIGRpc2sgdW50
aWwgdGhlIGlub2RlIGlzIGV2aWN0ZWQgYW5kIHJlLXJlYWQKPgo+IExldCBmMmZzX3dyaXRlX2Jl
Z2luKCkgc2tpcCB0aGUgY29tcHJlc3Npb24gb3ZlcndyaXRlIHByZXBhcmF0aW9uIGZvcgo+IHN1
Y2ggaW5vZGVzIGFuZCByZW1vdmUgdGhlIGNvbXByZXNzZWQtZmlsZSBnYXRlIGluCj4gZjJmc19y
ZWFkX2RhdGFfbGFyZ2VfZm9saW8oKSBzbyB0aGUgZGF0YSBpcyBzaW1wbHkgcmVhZC93cml0dGVu
IGFzCj4gcmVndWxhciBibG9ja3MuCj4KClBhdGNoIDE0IHJlbW92ZXMgdGhlIGNvbXByZXNzZWQt
ZmlsZSBnYXRlIGluCmYyZnNfcmVhZF9kYXRhX2xhcmdlX2ZvbGlvKCkgdW5kZXIgdGhlCmFzc3Vt
cHRpb24gdGhhdCAiZGF0YSBzdGF5cyB1bmNvbXByZXNzZWQgb24gZGlzayIuCgpIb3dldmVyLCBp
ZiBhIGZpbGUgYWxyZWFkeSBjb250YWlucyBleGlzdGluZyBjb21wcmVzc2VkIGNsdXN0ZXJzIG9u
CmRpc2sgKGUuZy4gZnJvbQplYXJsaWVyIHdyaXRlcyBiZWZvcmUgbGFyZ2UgZm9saW9zIG9yIGNy
ZWF0ZWQgd2l0aG91dCBsYXJnZSBmb2xpb3MpLAoKYGYyZnNfcmVhZF9kYXRhX2xhcmdlX2ZvbGlv
KClgIHdpbGwgaXNzdWUgcmVndWxhciBiaW8gcmVhZHMgd2l0aG91dApkZWNvbXByZXNzaW5nIHRo
ZW0uCgpVc2Vyc3BhY2UgcmVhZGluZyBmcm9tIGFuIGV4aXN0aW5nIGNvbXByZXNzZWQgY2x1c3Rl
ciB3aWxsIHJlY2VpdmUgcmF3CmNvbXByZXNzZWQKYnl0ZXMgaW5zdGVhZCBvZiBwbGFpbnRleHQg
ZGF0YS4KCkZpeDogSWYgYW4gaW5vZGUgaGFzIGV4aXN0aW5nIGNvbXByZXNzZWQgY2x1c3RlcnMg
KG9yIHVudGlsIGxhcmdlCmZvbGlvIHJlYWQgcGF0aApzdXBwb3J0cyBkZWNvbXByZXNzaW9uKSwg
SSB0aGluayB3ZSBtdXN0IG5vdCByZWFkIGNvbXByZXNzZWQgY2x1c3RlcnMKdmlhIGYyZnNfcmVh
ZF9kYXRhX2xhcmdlX2ZvbGlvKCkuCgpUaGFua3MsCgo+IFNpZ25lZC1vZmYtYnk6IE5hbnpoZSBa
aGFvIDx6aGFvbmFuemhlQHhpYW9taS5jb20+Cj4gLS0tCj4gIGZzL2YyZnMvZGF0YS5jIHwgOSAr
Ky0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2RhdGEuYyBiL2ZzL2YyZnMvZGF0YS5jCj4gaW5k
ZXggMmUyMDgzM2M2NDE3Li5iZWZjZGMzNzQyZjYgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJmcy9kYXRh
LmMKPiArKysgYi9mcy9mMmZzL2RhdGEuYwo+IEBAIC0yOTU1LDEyICsyOTU1LDYgQEAgc3RhdGlj
IGludCBmMmZzX3JlYWRfZGF0YV9sYXJnZV9mb2xpbyhzdHJ1Y3QgaW5vZGUgKmlub2RlLAo+ICAg
ICAgICAgaW50IHJldCA9IDA7Cj4gICAgICAgICBib29sIGZvbGlvX2luX2JpbyA9IGZhbHNlOwo+
Cj4gLSAgICAgICBpZiAoZjJmc19jb21wcmVzc2VkX2ZpbGUoaW5vZGUpKSB7Cj4gLSAgICAgICAg
ICAgICAgIGlmIChmb2xpbykKPiAtICAgICAgICAgICAgICAgICAgICAgICBmb2xpb191bmxvY2so
Zm9saW8pOwo+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4gLSAgICAgICB9
Cj4gLQo+ICAgICAgICAgbWFwLm1fc2VnX3R5cGUgPSBOT19DSEVDS19UWVBFOwo+Cj4gICAgICAg
ICBpZiAocmFjKQo+IEBAIC00OTM1LDcgKzQ5MjksOCBAQCBzdGF0aWMgaW50IGYyZnNfd3JpdGVf
YmVnaW4oY29uc3Qgc3RydWN0IGtpb2NiICppb2NiLAo+ICAgICAgICAgfQo+Cj4gICNpZmRlZiBD
T05GSUdfRjJGU19GU19DT01QUkVTU0lPTgo+IC0gICAgICAgaWYgKGYyZnNfY29tcHJlc3NlZF9m
aWxlKGlub2RlKSkgewo+ICsgICAgICAgaWYgKGYyZnNfY29tcHJlc3NlZF9maWxlKGlub2RlKSAm
Jgo+ICsgICAgICAgICAgICFtYXBwaW5nX2xhcmdlX2ZvbGlvX3N1cHBvcnQoaW5vZGUtPmlfbWFw
cGluZykpIHsKPiAgICAgICAgICAgICAgICAgaW50IHJldDsKPiAgICAgICAgICAgICAgICAgc3Ry
dWN0IHBhZ2UgKnBhZ2U7Cj4KPiAtLQo+IDIuNDMuMAo+Cj4KPgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGludXgtZjJmcy1kZXZlbCBtYWlsaW5n
IGxpc3QKPiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8v
bGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZz
LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZz
LWRldmVsCg==
