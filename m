Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F92C79FB6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NL2JtNHtvtdogVP7TkhvfJ9Nq9orKHMYz2b2P+vNNsI=; b=AgOWIfE18BqrkItH/pMJFm1bHi
	vsPrdpyPJoBhWpHiz1zX9bLDsT5KBw0neHP6sqLz56pRpgZCAex3WG6bE3kUCrQrOrkUXctSgJhPP
	RKhAohdsIqS55vKvoUr88e6tK7GhSuUyBY7tqP/6r9bqslTsfEZgD+tKYxCjVkDPADlI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4PX2-0004vu-Cu;
	Wed, 09 Sep 2026 21:08:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x4PX0-0004vo-Qn
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 21:08:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a3kjeMoPbPYK+FlEK48cN5+JcIoFn3BIfOcaWDPNgZ4=; b=X5GZbrPQxoJxWMOa5AATOTi1u4
 4Cw6cuYDCAqAID9aKv11BZjQg4yTFFmyCy3E3x1Fc4wfrIl+U0MEKTMzYiixmKt0SE/GwVCBsYcgr
 89o/meGUh+ZOBgAAmKseVmlvgkZUP4vNXObULL+5FvtEs7WLHpmOQOs9Yxb27iQ3Mkjc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=a3kjeMoPbPYK+FlEK48cN5+JcIoFn3BIfOcaWDPNgZ4=; b=TerahSuJeSc5KBuoetPmPm1xeT
 EAmdd1sJ5fo3JxzNpwv5MYCdOWZStYqSn5KSD4A8jWRqhFcEL6gFEztnNtiMeLuiDNmdhc6tuPcCj
 QNxGwviaD74qeBmuAOtsEruRUEJ3GxixnpusIfI5vyr1zd/pkddtM9PQDaXh8mpD50CE=;
Received: from mail-lj1-f175.google.com ([209.85.208.175])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4PWz-0007vO-Eh for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 21:08:34 +0000
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-3a4a82aa383so9169441fa.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 14:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788988107; cv=none;
 d=google.com; s=arc-20260327;
 b=g7MexVVKTcCmvqoym34zc7Khzbe0so7uF8Xs9bYZhBp4PvzzuAX3fSqHRxiCeqS3QM
 LGIEw1Z8BSWsqpCCqrL8RJHBiKLimjzkBCVXhSNEHNGp3zHGsB4x0i5AU1eDF1Nrm/LL
 o4bT6i7xxwwlG48win8O3Jgs68DMDnXr8R0BBnDM5ZTQPBygfUVSdZWilnCjGr4XaDdJ
 81usmaWLB4HchAEIWGB+40WyvzrY6JIA4cvjyok2mcaYEjDEz1/hzAfH/70q42q7bVeo
 ZdqOyAKA2T+0peaKshq1XqPwM5FfeoK5mpzekwOP9sw4lRY/W343S1Z+LH7MHTPE12NU
 dUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a3kjeMoPbPYK+FlEK48cN5+JcIoFn3BIfOcaWDPNgZ4=;
 fh=KjnTvq9VOuBhQagGxfjTT4+Ama4E15/t23kSO5tagic=;
 b=gsuyvYiqM6K9SKAkhAXCPMCsCtkYpa5KcMlKX7+8lyrJdQ96nW+EBBTuD3b2I/uDzK
 dAVyENDndn4K0Tct2ElDSVR734MBTdNNQnC0vohhAIgCE0ej/U8dCl7C+kBTvOEXybYP
 1SiV6o2P54RBfxuc+Yw3oe4U5IBHjg+AWkjbQtRWSKCNTtq8a3Fb71zoAvMk0vTiX27e
 96lJxANz+S/SsLIwv+l5wNmAiBD+xc75pA6qEdVVCmUzvZvJ6aADsJVI5Zwnh9RwDBNm
 vq/3Xv/EYrOfs3otGqP6QNIuetjRuvu+2M517oHZ2NRAIO+X0hSCDdvdE63TfRjpXZne
 e4Tg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788988107; x=1789592907; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a3kjeMoPbPYK+FlEK48cN5+JcIoFn3BIfOcaWDPNgZ4=;
 b=n2cRWVCxG1Xic0Dl6VPchT5I0sQYiFyv6NdcPsNQVZqheHCspLYsWjE0MDZx4qCVvW
 jnfd1F4mWVRoml4iD6oK1MTAcqMLe31YnsD3CL9TcUyvhGnymCcGVJ/URbfOX1fMD0n2
 kk296dOO+ai9eIDMI8leDXmABPkpMydfOiLgxJ87nlJNyDwyr1rzh7gdVXtBKD+g2/AL
 SPGdtdwZMQDwOzUm2DYez8M46Merg76tskBBJv+wWvnbtAwLghnP8C7Q/HA99BnsZffm
 AtC26tmrYpju0F58qKPrNvxfnRt7ZjP2W3IOTJRIb2YHRSuhSqIc+g2AxHmxai5T9XmW
 aCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788988107; x=1789592907;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a3kjeMoPbPYK+FlEK48cN5+JcIoFn3BIfOcaWDPNgZ4=;
 b=X4YRMM+h+TlVMsouz53r3wpEai0EQ2UY7Mx3bwKB6cy2AigzPNT1DYXZiErCl9GkhI
 WffFpkdaxQa6AxzlFDOpvy4/1KvbTjmuePBFJ2+N7v3A/CNC/5/MktzkFpomh3+9drD8
 DgGBHT/LaWQ25zC5eDeRBYvwtyx6zGpNgk9Zef5/19GkEyKmb34VXj2paDWc92XpUNJR
 XE2tvcZeqHY1Vp5DzAN7+BcKir/aCQ2OgBv0t4/k2YDGTz72J+S3472rUQ60kSVgKJ1y
 ZvixUQ+LwgDfEG841VXzAfckr7HDLqwhAun3jEhH026jvPkkL5fK7X/BkjI6ECNgQkXX
 r+vQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZvklYQrxF+M2UMhP9ntL7f2j/1scE4gjANI1TiwF5bca0ah6nhRF6tbjkLfre/tvPJ/t75XrdJsnPcTiDWu8q@lists.sourceforge.net
X-Gm-Message-State: AFuF++mVKchmyoh99OXj9IfpAi6creNSFeU7a0Koz9klxnG62SQbTt4V
 ax8bYzVzVdJS7k66VyfIHlPaf5GkN7bn2r4+Hl+lz0Bq2UPfjONsaWEXozS9NN5sCh7g0tdh3BB
 SDPnZCvbCxmi8iwQgCntf8eZNnb3MJog=
X-Gm-Gg: AYBFou12PUJRkw9Dahc8fIM/iem/kA7htZc+AFP2uTYPHGMJIw9OeXPN6tNK1tYAh9Y
 admi+V78H3sGRERwbkMV1s6+czShgEOEp3VbkafOnrkMYxzokB97OAImqenh1nPdq/6yYi9lsFx
 dkwCC9fVNbFU+DEt7rIaCufu/IuhR2Rqqb9JH6FT+dx7pXLaymgDn+UhonL3dQWNFBTkrfs0LGE
 09axyjk59uxlV8EtiJibQmGDJjB5uQ6WL67G9Z4M1uqUQyK1e0sROnb2V17V7r7Bhjc1RSf74LQ
 SDUf1XZD+EYBxmXxuV/fKvg9CM0n1vJ9eU5a3wqyWttAAFalZcRzTRT83iBL9CiLODNjuZnNcxy
 m4NRfIhm1vHAx6KDyuozAKcloL6wMZB+i/YpwlMPld406
X-Received: by 2002:a05:651c:a342:b0:3a3:7681:6d5f with SMTP id
 38308e7fff4ca-3a3768174b4mr46131301fa.23.1788988106455; Wed, 09 Sep 2026
 14:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <CACOAw_yjqS5DDUxQdiqbQZLdXW-fQzHmVPHf32bdBhwth=kLOw@mail.gmail.com>
 <20260907101238.2475724-1-zhaonanzhe@xiaomi.com>
In-Reply-To: <20260907101238.2475724-1-zhaonanzhe@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 9 Sep 2026 14:08:13 -0700
X-Gm-Features: AcwNN1X8zzbVYXyx30ryZjm7jh8qFvwK56OP67Zmg883Ne_Vke-tHsLdVR1kB_c
Message-ID: <CACOAw_xat4eD_WW+r=xtZCxN-HyVgyFQCEzx49UkJYxnY47_hQ@mail.gmail.com>
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Headers-End: 1x4PWz-0007vO-Eh
Subject: Re: [f2fs-dev] [PATCH 05/14] f2fs: support large folio writeback
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBTZXAgNywgMjAyNiBhdCAzOjEy4oCvQU0gTmFuemhlIFpoYW8gPG56emhhby5zaWdt
YUBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCAyNyBBdWcgMjAyNiAxNTozOToxOSAtMDcw
MCwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gPiBJZiBmMmZzX3dyaXRlX3NpbmdsZV9kYXRhX2ZvbGlv
KCkgZmFpbHMgb24gc3VicGFnZSAxLCBqdW1waW5nCj4gPiB0byBgb3V0YCB1bmNvbmRpdGlvbmFs
bHkgY2xlYXJzIHRoZSBkaXJ0eSBiaXRtYXAgZm9yIHRoZSBFTlRJUkUgZm9saW8KPiA+ICgwIHRv
IGZvbGlvX3NpemUpLAo+ID4gYW5kIGRlY3JlbWVudHMgdGhlIGlub2RlIGRpcnR5IHBhZ2VzLgo+
ID4KPiA+IFRoZSB1bndyaXR0ZW4gZGlydHkgc3VicGFnZXMgbG9zZSB0aGVpciBkaXJ0eSB0cmFj
a2luZyBhbmQgd2lsbCBiZQo+ID4gZGlzY2FyZGVkIGNsZWFubHkKPiA+IHVuZGVyIG1lbW9yeSBw
cmVzc3VyZSwgY2F1c2luZyBzaWxlbnQgZGF0YSBsb3NzLgo+ID4KPiA+IEZpeDogT25seSBjbGVh
ciBkaXJ0eSBiaXRzIGZvciBzdWNjZXNzZnVsbHkgc3VibWl0dGVkIHN1YnJhbmdlcyAoYDAsCj4g
PiBwb3NgKSwgYW5kIHJlZGlydHkKPiA+IHRoZSBmb2xpbyBpZiB1bndyaXR0ZW4gZGlydHkgc3Vi
cGFnZXMgcmVtYWluIHdoZW4gYW4gZXJyb3Igb2NjdXJzLgo+Cj4gVGhhbmtzIGZvciB0aGUgcmV2
aWV3LiBBZ3JlZWQuCj4gTXkgY2hhbmdlIGh1bmsgbWF5IGxpa2UgdGhpczoKPgo+IGRpZmYgLS1n
aXQgYS9mcy9mMmZzL2RhdGEuYyBiL2ZzL2YyZnMvZGF0YS5jCj4gQEAgZjJmc193cml0ZV9zaW5n
bGVfZGF0YV9mb2xpbygpOgo+IC1zdGF0aWMgaW50IGYyZnNfd3JpdGVfc2luZ2xlX2RhdGFfZm9s
aW8oc3RydWN0IGZvbGlvICpmb2xpbywgaW50ICpzdWJtaXR0ZWQsCj4gK3N0YXRpYyBpbnQgZjJm
c193cml0ZV9zaW5nbGVfZGF0YV9mb2xpbyhzdHJ1Y3QgZm9saW8gKmZvbGlvLCBpbnQgKnN1Ym1p
dHRlZCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHdy
aXRlYmFja19jb250cm9sICp3YmMsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGVudW0gaW9zdGF0X3R5cGUgaW9fdHlwZSwKPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdTY0IHN0YXJ0LCB1NjQgZW5kKQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1NjQgKnBvcywgdTY0IGxlbikKPiAgewo+ICAgICAgICAg
c3RydWN0IGlub2RlICppbm9kZSA9IGZvbGlvLT5tYXBwaW5nLT5ob3N0Owo+ICAgICAgICAgc3Ry
dWN0IGYyZnNfc2JfaW5mbyAqc2JpID0gRjJGU19JX1NCKGlub2RlKTsKPiAgICAgICAgIGJvb2wg
YXRvbWljX2NvbW1pdCA9IGYyZnNfaXNfYXRvbWljX2ZpbGUoaW5vZGUpICYmCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvbGlvX3Rlc3RfZjJmc19hdG9taWMoZm9s
aW8pOwo+ICAgICAgICAgc3RydWN0IGlub2RlICpkbl9pbm9kZSA9IGF0b21pY19jb21taXQgPwo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBGMkZTX0koaW5vZGUpLT5j
b3dfaW5vZGUgOiBpbm9kZTsKPiAtICAgICAgIHU2NCBwb3MgPSBmb2xpb19wb3MoZm9saW8pOwo+
IC0gICAgICAgcGdvZmZfdCBzdGFydF9pZHggPSAoc3RhcnQgLSBwb3MpID4+IFBBR0VfU0hJRlQ7
Cj4gLSAgICAgICBwZ29mZl90IGVuZF9pZHggPSAoZW5kIC0gMSAtIHBvcykgPj4gUEFHRV9TSElG
VDsKPiArICAgICAgIHBnb2ZmX3Qgc3RhcnRfaWR4ID0gKCpwb3MgLSBmb2xpb19wb3MoZm9saW8p
KSA+PiBQQUdFX1NISUZUOwo+ICsgICAgICAgcGdvZmZfdCBlbmRfaWR4ID0gKCpwb3MgKyBsZW4g
LSAxIC0gZm9saW9fcG9zKGZvbGlvKSkgPj4gUEFHRV9TSElGVDsKPiAgICAgICAgIGludCBsb2Nh
bF9zdWJtaXR0ZWQgPSAwOwo+ICAgICAgICAgaW50IGVyciA9IDA7Cj4gQEAgSVBVL09QVSBjb21t
b24gd3JpdGVfZG9uZToKPiAgICAgICAgICAgICAgICAgZXJyID0gZjJmc19pbnBsYWNlX3dyaXRl
X2RhdGEoJmZpbyk7Cj4gICAgICAgICAgICAgICAgIGlmIChlcnIpIHsKPiAgICAgICAgICAgICAg
ICAgICAgICAgICBpZiAoZnNjcnlwdF9pbm9kZV91c2VzX2ZzX2xheWVyX2NyeXB0byhpbm9kZSkp
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmc2NyeXB0X2ZpbmFsaXplX2JvdW5j
ZV9wYWdlKAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZmaW8uZW5jcnlwdGVkX3BhZ2UpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gcm9s
bGJhY2tfbm9fZG5vZGU7Cj4gICAgICAgICAgICAgICAgIH0KPgo+ICAgICAgICAgICAgICAgICBs
b2NhbF9zdWJtaXR0ZWQrKzsKPiAgICAgICAgICAgICAgICAgc2V0X2lub2RlX2ZsYWcoaW5vZGUs
IEZJX1VQREFURV9XUklURSk7Cj4gLSAgICAgICAgICAgICAgIGNvbnRpbnVlOwo+ICsgICAgICAg
ICAgICAgICBnb3RvIHdyaXRlX2RvbmU7Cj4gICAgICAgICB9Cj4gIC4uLgo+ICAgICAgICAgICAg
ICAgICBmMmZzX291dHBsYWNlX3dyaXRlX2RhdGEoJmRuLCAmZmlvKTsKPiAgICAgICAgICAgICAg
ICAgbG9jYWxfc3VibWl0dGVkKys7Cj4gICAgICAgICAgICAgICAgIHNldF9pbm9kZV9mbGFnKGlu
b2RlLCBGSV9BUFBFTkRfV1JJVEUpOwo+ICAgICAgICAgICAgICAgICB0cmFjZV9mMmZzX2RvX3dy
aXRlX2RhdGFfcGFnZShmb2xpbywgT1BVKTsKPiAgICAgICAgICAgICAgICAgZjJmc19wdXRfZG5v
ZGUoJmRuKTsKPiAtICAgICAgICAgICAgICAgY29udGludWU7Cj4gKyAgICAgICAgICAgICAgIGdv
dG8gd3JpdGVfZG9uZTsKPiArCj4gK3dyaXRlX2RvbmU6Cj4gKyAgICAgICAgICAgICAgICpwb3Mg
PSAodTY0KShkYXRhX2lkeCArIDEpIDw8IFBBR0VfU0hJRlQ7Cj4gKyAgICAgICAgICAgICAgIGNv
bnRpbnVlOwo+IEBAIGYyZnNfd3JpdGVfY2FjaGVfZm9saW9zIGxvb3AgKyBvdXQ6Cj4gICAgICAg
ICAgICAgICAgIHdoaWxlICgocl9sZW4gPSBmZnNfZmluZF9kaXJ0eV9yYW5nZShmb2xpbywgJnBv
cywgZW5kX3BvcykpKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgZXJyID0gZjJmc193cml0
ZV9zaW5nbGVfZGF0YV9mb2xpbyhmb2xpbywgJnN1Ym1pdHRlZCwKPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgd2JjLCBpb190eXBlLCBwb3MsIHBvcyArIHJfbGVuKTsK
PiArICAgICAgICAgICAgICAgICAgICAgICBlcnIgPSBmMmZzX3dyaXRlX3NpbmdsZV9kYXRhX2Zv
bGlvKGZvbGlvLCAmc3VibWl0dGVkLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB3YmMsIGlvX3R5cGUsICZwb3MsIHJfbGVuKTsKPiAgICAgICAgICAgICAgICAgICAg
ICAgICBmb2xpb19zdWJtaXR0ZWQgKz0gc3VibWl0dGVkOwo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChlcnIpCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsK
Pgo+ICAgICAgICAgICAgICAgICAgICAgICAgIG53cml0dGVuICs9IHN1Ym1pdHRlZDsKPiAtICAg
ICAgICAgICAgICAgICAgICAgICBwb3MgKz0gcl9sZW47Cj4gICAgICAgICAgICAgICAgIH0KPiAg
Li4uCj4gIG91dDoKPiAtICAgICAgICAgICAgICAgZjJmc19mZnNfY2xlYXJfc3VicmFuZ2VfZGly
dHkoZm9saW8sIDAsIGZvbGlvX3NpemUoZm9saW8pKTsKPiAtICAgICAgICAgICAgICAgaW5vZGVf
ZGVjX2RpcnR5X3BhZ2VzKGlub2RlKTsKPiArICAgICAgICAgICAgICAgaWYgKGYyZnNfZmZzX2Ns
ZWFyX3N1YnJhbmdlX2RpcnR5KGZvbGlvLCAwLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAoZXJyID8gcG9zIDogZW5kX3BvcykgLSBmb2xpb19wb3MpKQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGZvbGlvX3JlZGlydHlfZm9yX3dyaXRlcGFnZSh3YmMsIGZvbGlv
KTsKPiArICAgICAgICAgICAgICAgZWxzZQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlub2Rl
X2RlY19kaXJ0eV9wYWdlcyhpbm9kZSk7Cj4KPiBCdHcsIEkgdGhpbmsgdGhlIG5hbWUgZjJmc193
cml0ZV9zaW5nbGVfZGF0YV9mb2xpbygpIGlzIG1pc2xlYWRpbmcgbm93Cj4gdGhhdCBpdCB3cml0
ZXMgYSBkaXJ0eSBzdWJyYW5nZSBvZiBhIGxhcmdlIGZvbGlvOyB3b3VsZAo+IGYyZnNfd3JpdGVf
Zm9saW9fZGlydHlfcmFuZ2UoKSBzb3VuZCBiZXR0ZXI/CgpIaSBOYW56aGUsCgpUaGFua3MgZm9y
IHRoZSB1cGRhdGVkIGh1bmsuIFRoZSBsb2dpYyBsb29rcyBnb29kIHRvIG1lLiBUaGUgbmV3IG5h
bWUKb2YgdGhlIGZ1bmN0aW9uIHNvdW5kcyBiZXR0ZXIuCgo+Cj4gVGhhbmtzLAo+IE5hbnpoZQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYy
ZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYy
ZnMtZGV2ZWwK
