Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F0606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ATj4aT0n;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TiM1qy/7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TjpSCbsH;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q36JbU+2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Date:References:In-Reply-To:To:Message-ID:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=7ZUF6N1oS/EQZfctl1l2AfsnemluB6UGWqrdAsK3zZo=; b=ATj4aT0nQ1JsJF2x5EO4EjNkhj
	oxjq+eaF5/9ffJ5SIFas+1BzdhDoylcghPpIIBLKyXC16A1FkiwAoRBe9xtEYuzZrmpjPZmU0zIHW
	eqCO6uccwsmUB6yPZvd6k4gLnopOpKz/o2ta5ct7WqkD13GGczphF4J4izwJtH1GADUU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRlhK-0000000045g-1Iig;
	Fri, 13 Nov 2026 07:27:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <sashiko-bot@kernel.org>) id 1xRlhF-0000000045Y-3NO4
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 07:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Date:Content-Transfer-Encoding:Content-Type:
 References:In-Reply-To:Cc:To:Reply-To:Subject:From:Message-ID:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=s7TY5wKuFz0pffBAJMdbPbg+Xa5yLuxe6GHqxDP3cCo=; b=TiM1qy/7dh/U
 o31bo1XkSgXROnyZraFCQ88nww11VqAhQJGPc20xHX95GYj0YtZONA0i6k07hD92cQCpXNaV/wMJ1
 Rp6+cdfx66pxKfwWt62D3RIlzk7qiwj2WvksD9kwFThPYE+tsfe0eMweYd+mqVsbF0vQ0Soaz3RyO
 mxwD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Date:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:
 Reply-To:Subject:From:Message-ID:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s7TY5wKuFz0pffBAJMdbPbg+Xa5yLuxe6GHqxDP3cCo=; b=TjpSCbsHeuxLVhfktlfiRuhS9u
 04wwH5VmL8CDAPH99CemUMLcrL2UBGGtyUWb6nBAeTh0PATJ8B+NiMrOtdLkRbWhd0LjOHoSGQOMn
 f1iOmd213hnmYK573RVakgwale23Rf2r4g/1CacOr6cXcKXK6shR7cujECPxVGvmyOg4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRlhF-000000007On-0hjS
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 07:27:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5F9C459B2;
 Fri, 13 Nov 2026 07:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B371F000C4;
 Fri, 13 Nov 2026 07:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794554855;
 bh=s7TY5wKuFz0pffBAJMdbPbg+Xa5yLuxe6GHqxDP3cCo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q36JbU+2pW7+P287G1OtB3Rp+nXJ6AXUX16lfBsYTCl0gm19oFQRAuM9LhjRnqWdW
 4jwK6wPcuaEsx53bibw2zAMxE0GC5LKAWBp3IiQrOzrUsupgle0o8D+P6Cf/Tq828m
 q1ZzjPW8k0JSfe9X1kTgn6yLQ17m4ix+hMqGSsVcYF8xAExJvGc9IV1UhnZ/Ppy7Hd
 m50xn93LRMRmSiH1U7mHBEIGs3DCYBw6D7KLh/4AKCwfwDfijqXUKfYk11p5LUtwhc
 euxWm1E1jc4eB0q4ezewRqk1dbkYg1Wvb7fIYpJdgsrR0Kv5J1TcwIY9RVfMduGIlZ
 HtDCmUrAKP/Ng==
Message-ID: <sashiko-outbox-212348@kernel.org>
To: "Sarthak Kukreti via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261113065332.929085-2-sarthakkukreti@google.com>
References: <20261113065332.929085-1-sarthakkukreti@google.com>
 <20261113065332.929085-2-sarthakkukreti@google.com>
Date: Fri, 13 Nov 2026 07:27:34 +0000
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xRlhF-000000007On-0hjS
Subject: Re: [f2fs-dev] [PATCH 1/3] libfs: reject casefolded names that fold
 to ".", "..", or empty
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: sashiko-bot--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBVbmljb2RlIG5vcm1hbGl6YXRpb24gYW5kIGNhc2Vmb2xkaW5nICh1dGY4X2Nhc2Vmb2xkKCkp
IHN0cmlwcyBjb2RlCj4gcG9pbnRzIHdpdGggdGhlIERlZmF1bHRfSWdub3JhYmxlX0NvZGVfUG9p
bnQgcHJvcGVydHksIHN1Y2ggYXMgVSsyMDJFCj4gKFJJR0hULVRPLUxFRlQgT1ZFUlJJREUpIG9y
IFUrMjAwQiAoWkVSTyBXSURUSCBTUEFDRSkuIEFzIGEgcmVzdWx0Ogo+IAo+IDEuIEEgZmlsZW5h
bWUgY29uc2lzdGluZyBvZiAiLiIgb3IgIi4uIiBmb2xsb3dlZCBieSBpZ25vcmFibGUgY2hhcmFj
dGVycwo+ICAgIChlLmcuICIuXHhlMlx4ODBceGFlIiBvciAiLi5ceGUyXHg4MFx4YWUiKSBieXBh
c3NlcyBWRlMgc3BlY2lhbC1lbnRyeQo+ICAgIGhhbmRsaW5nIGR1cmluZyBwYXRoIHdhbGssIGJ1
dCBjYXNlZm9sZHMgdG8gIi4iIG9yICIuLiIuCj4gMi4gQSBmaWxlbmFtZSBjb25zaXN0aW5nIHNv
bGVseSBvZiBpZ25vcmFibGUgY2hhcmFjdGVycyAoZS5nLgo+ICAgICJceGUyXHg4MFx4YWUiKSBj
YXNlZm9sZHMgdG8gdGhlIGVtcHR5IHN0cmluZyAiIiAobGVuZ3RoIDApLCBjYXVzaW5nCj4gICAg
YW55IHR3byBkaXN0aW5jdCBpZ25vcmFibGUtb25seSBmaWxlbmFtZXMgdG8gY29tcGFyZSBhbmQg
aGFzaCBhcwo+ICAgIGVxdWFsLgo+IAo+IFVwZGF0ZSBnZW5lcmljX2NpX2RfaGFzaCgpLCBnZW5l
cmljX2NpX2RfY29tcGFyZSgpLCBnZW5lcmljX2NpX21hdGNoKCksCj4gYW5kIGdlbmVyaWNfY2lf
dmFsaWRhdGVfc3RyaWN0X25hbWUoKSB0byByZWplY3QgY2FzZS1pbnNlbnNpdGl2ZQo+IGhhc2hp
bmcsIG1hdGNoaW5nLCBhbmQgY3JlYXRpb24gb2YgZmlsZW5hbWVzIHRoYXQgY2FzZWZvbGQgdG8g
IiIsICIuIiwKPiBvciAiLi4iLCB3aGlsZSBwcmVzZXJ2aW5nIGV4YWN0IGJ5dGUtZXF1YWxpdHkg
bWF0Y2hlcyAoc3VjaCBhcyBORlMKPiBleHBvcnQgbG9va3VwcyBvZiBsaXRlcmFsICIuLiIpLiBV
c2luZyBhIDMtYnl0ZSBzdGFjayBidWZmZXIgd2l0aAo+IHV0ZjhfY2FzZWZvbGQoKSBkZXRlY3Rz
IGFsbCB0aHJlZSBjYXNlcyBpbiBPKDEpIHNwYWNlIHdpdGhvdXQgaGVhcAo+IGFsbG9jYXRpb25z
Lgo+IAo+IEZpeGVzOiBjODQzODQzZTcxNGMgKCJmczogQWRkIHN0YW5kYXJkIGNhc2Vmb2xkaW5n
IHN1cHBvcnQiKQo+IENvLWRldmVsb3BlZC1ieTogRG1pdHJ5IFRvcm9raG92IDxkdG9yQGdvb2ds
ZS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IFRvcm9raG92IDxkdG9yQGdvb2dsZS5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogU2FydGhhayBLdWtyZXRpIDxzYXJ0aGFra3VrcmV0aUBnb29nbGUu
Y29tPgoKU2FzaGlrbyBoYXMgcmV2aWV3ZWQgdGhpcyBwYXRjaCBhbmQgZm91bmQgbm8gaXNzdWVz
LgoKLS0gClNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNl
dC8yMDI2MTExMzA2NTMzMi45MjkwODUtMS1zYXJ0aGFra3VrcmV0aUBnb29nbGUuY29tP3BhcnQ9
MQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51
eC1mMmZzLWRldmVsCg==
