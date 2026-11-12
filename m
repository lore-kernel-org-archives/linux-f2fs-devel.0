Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53A606A32D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CPtsw4ef;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iUt1yk85;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ilFVhBdN;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JLBsAVDL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=l53lkm3MBPBE9U7veyTi0dqqm9oZ+AIJr2fhSqs0ExY=; b=CPtsw4efueNQ4H
	2G5fPUGrDQZB5lq5NAzm+jUJho5D4mm8ZzYLsKcHx3ZR6gMZ/P2WUTN+6gDaJut/jV2AksjUatkW5
	cNWpkiK5j16cSflK6awORur2mjtisaCmyJPMJVXmhnJce5/8TlzFKpHaLAjajuDabC0yEh8WY6+L9
	mOM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRQDI-000000002JK-3qvT;
	Thu, 12 Nov 2026 08:31:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xRQD5-000000002HM-0S13
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 08:31:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eanlO8+qwK7IG5ntFg8sssJop/6AkWJli9sPt2tg8Po=; b=iUt1yk85QRWQJIfA60Wkt4S3Ll
 F6Nbk4ydePZI1/JzAhPEmXEhNqUrfnpmcXA4WSHVlJTBiVMFz3GgpJBbhIhult4gRdK00mqB2iA6V
 60EpP1EyZopDX61bX+oVhmRefqC1xAtlNYEj2FkSW/2+Wuz8KvUtG8oXrVildT0isYU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eanlO8+qwK7IG5ntFg8sssJop/6AkWJli9sPt2tg8Po=; b=ilFVhBdN4enuteUaJcLYVxyhLG
 JBupo2AbaN/6I7g6PFp4n/8oGMZQuZqxsIbqaXeErnPPGWstq7ajbz94gvdkTSagRRH0yVrni/Hxw
 yh6Q5VcLZJdfyaPx66r3wORBfLSVMCAuOcURNg3p+tvap8SvDDGUs4ogPahHPTI9hzs8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRQD4-000000000Uh-2mcL
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 08:31:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1208663A89;
 Thu, 12 Nov 2026 08:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D198F1F00A0A;
 Thu, 12 Nov 2026 08:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794472260;
 bh=eanlO8+qwK7IG5ntFg8sssJop/6AkWJli9sPt2tg8Po=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=JLBsAVDL04q5Rv/oBYdRC57LpRpSahHDXdVArIMbh88SZOB7r/sK7PasYqdQrs6dU
 4tW2/LB3m8r8uw5rdl+gCxCj+xr0e6S85RrMTzpeDj/5p3N19wTEi8mF1J9l9nkfTx
 Unhp59TFSIdaU1jLfKLEbdrfmQj0cM5NPF540qdcQ2zLYhh88uYvATUylQ5Bofhd28
 fk0/80258SeNg/iynvmwX0yuToa1/e4TlM4Oc2XmKv8CE6za/2ZUxTpy8m2j+Okpbl
 yw9IOXjK9iz+JlYFhQAKXFfBJ0RxyB8PbdJPmH+8bH33xuQtnbaKfKLS2kMlQy1Xgx
 33qUnKXg7U/mQ==
Message-ID: <0e156b8a-2876-4bbe-b16c-55c70b3201b3@kernel.org>
Date: Thu, 12 Nov 2026 16:30:58 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seongjae Jeong <jsjlee1020@gmail.com>
References: <20261004061007.7433-1-jsjlee1020@gmail.com>
 <f3f5fe2c-f0f5-4c23-a2f7-6cb5e09ced5a@kernel.org>
 <CAPHXVrzaWHYccYe+PWLeAf_N3md8ens0UsW7aH-047KGhM4BUg@mail.gmail.com>
 <102da404-ab62-4ba6-b46a-1846ca64c72b@kernel.org>
 <CAPHXVry2O-AYxTvGdzu+m6b3Q=ho=xL0kpWWqCn0vjj-gOe0ZQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPHXVry2O-AYxTvGdzu+m6b3Q=ho=xL0kpWWqCn0vjj-gOe0ZQ@mail.gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRQD4-000000000Uh-2mcL
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip further SIT updates for already
 invalidated blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, yi.sun@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gMTEvMTIvMjYgMTE6NDgsIFNlb25namFlIEplb25nIHdyb3RlOgo+IEhpIENoYW8sCj4gCj4g
VGhhbmtzIGZvciBjaGVja2luZy4KPiBJIGFncmVlIHRoYXQgODFmZmJkMjI0ZTVmIGlzIHRoZSBy
aWdodCBGaXhlcyB0YWcuCj4gCj4gSeKAmXZlIHNlbnQgdjIgd2l0aCBzdGFibGUgb24gQ2MgYW5k
IGFuIGFkZGl0aW9uYWwgRml4ZXMgdGFnIGZvcgo+IGE2NmNkZDk4NTUzMiB0byBjb3ZlciB0aGUg
ZGlzY2FyZCBiaXRtYXAgaGFuZGxpbmcuIERvZXMgdGhlIHNlY29uZAo+IEZpeGVzIHRhZyBsb29r
IGFwcHJvcHJpYXRlIHRvIHlvdT8KCkhpIFNlb25nSmFlLAoKSSBkb24ndCBzZWUgaG93IGNvbW1p
dCBhNjZjZGQ5ODU1MzIgKCJmMmZzOiBpbnRyb2R1Y2UgZGlzY2FyZF9tYXAgZm9yIGYyZnNfdHJp
bV9mcyIpCmludHJvZHVjZSB0aGUgYnVnPyBmcm9tIHRoZSB0aW1lbGluZSwgYXQgdGhhdCBwb2lu
dCB0aGVyZSBpcyBubyBlcnJvciBoYW5kbGluZyBpbgp1cGRhdGVfc2l0X2VudHJpZXMoKSBpZiBz
aXQgYml0bWFwIGlzIGluY29uc2lzdGVudCwgcmlnaHQ/CgpUaGFua3MsCgo+IAo+IFRoYW5rcywK
PiBTZW9uZ2phZQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby9saW51eC1mMmZzLWRldmVsCg==
