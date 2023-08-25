Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13931C83F01
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Aug 2023 22:44:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qZfXB-0001Im-Vi;
	Fri, 25 Aug 2023 22:44:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <drosen@google.com>) id 1qZfXA-0001Ig-LD
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 22:44:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tK+QJY4E1UOuHvMRNpsQhzdkVC4iiLEwKjXA5J73MNw=; b=Tz1NCbWe+wgJNffQpCmLD0EKz5
 Gw0klUmthwKKKDr6Q09vsbDYI3F6Wibv6caVfBK4qY1mHDI3LlK7QI/dKERWzxwzvsjzVn/iQrAA9
 E9mlS0M8oBBvRzqzaByrXnmFISiX2rKk3b3NBbSCvukIVi+ZM5gdt6R/AILJOrHOEcDY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tK+QJY4E1UOuHvMRNpsQhzdkVC4iiLEwKjXA5J73MNw=; b=Y3AO25cYqDQDtiIVBvCPL3GqEX
 XQEcsePrOcDNeZzxkOAc5NovSsZrUwFuGbaRAi4FHJALRYvJQyvN9yMvxN0o2Awi6e2kl7MNTLH+3
 lsagsvhNLEATS5fqq1Yro06k823INz3AfEY8sxE3d+aPNUwiKn726mxNqyPILPi/f9BQ=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qZfX9-0007MU-Rh for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 22:44:04 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-31c73c21113so1173919f8f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 25 Aug 2023 15:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693003437; x=1693608237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tK+QJY4E1UOuHvMRNpsQhzdkVC4iiLEwKjXA5J73MNw=;
 b=i+9eZsDNtgDkIL8zsBowEXLrzpegPtMbYBvhRsY2Ovtfjzu/vnr+Sqs6uY5nhSNAX2
 BnEPuZhrKl7bVboDAqhrN/wHgGbmDQeOrttgMUP5GR7tuWC3HXL2Vuf2beT1LcNX1/na
 QEEtfanxsJtkrmA1LbK+26mkWLMQ2w6P4GR4g+4Ii+qUpDDcjsvD+F9/7MdLk8VfshOg
 zTNTekgD8JoRYio77a4ns3O95D7sPBvdsCmjeJqd+Wq1PEqP7wuMvBv9TgKWzgmSSprn
 6W6dG2xp2xVmpmEaY1+kDR3pxESqF0xZw+rS9hj+HiSYNCLknsgvUzM7zMK/yJ8Molmr
 c7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693003437; x=1693608237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tK+QJY4E1UOuHvMRNpsQhzdkVC4iiLEwKjXA5J73MNw=;
 b=HhqnufjBsCm/gDqcN0sUl9Nc6x9juwnUykmxeclKYi1KVikxMHFXTWbf84hnm8QTiI
 EHlHmUS/UhRjtWtFzIm18uE1d0mTNp3abjWWjGFxAoslDC/Bw7RAjY2RiQAIlj+yRAyE
 x3hqMMXCk+fEJ4+Qi6ajxFcTQQZEqkJ+s1ZSjFbWWCuw9fPxk6GsN1UxKI0hq37dg40o
 X/zbZkGmGodVwutAmw6BEQAVYvJ19JMLCzP+sHlbdrMpzhDoQJi5Ztvdt99oJFSxF8hG
 OSIJa90HN6XsU6h5hLhR9lVVGbP3/aYAgD4KYv+esb6YEkVx1qn+GR2C+lLWKZxi24JV
 Tq/A==
X-Gm-Message-State: AOJu0YxW4FpzFiDMUpesEwQuF6lo53g6NiF4NJzuH//+zU9adNrXVe3u
 jtzYoPPM6+a4uDU+/jZL9qsQI99bTXsn7Gz/Dc2yYw==
X-Google-Smtp-Source: AGHT+IGM5nMsNEZzwWfqGfbC1twOzJR5q+MO9OPCU+Stp11bTMyS37OJlIO8+GjEyqAt/bOZ8JFjwBc+YNX3u1kvcvk=
X-Received: by 2002:adf:b613:0:b0:31c:81ef:f90a with SMTP id
 f19-20020adfb613000000b0031c81eff90amr1868722wre.47.1693003437251; Fri, 25
 Aug 2023 15:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230816011359.1964484-1-drosen@google.com>
 <20230816011359.1964484-2-drosen@google.com>
 <ZOjnXflReKGKgI+E@google.com>
In-Reply-To: <ZOjnXflReKGKgI+E@google.com>
Date: Fri, 25 Aug 2023 15:43:46 -0700
Message-ID: <CA+PiJmS5DMz-7U6kKZKvGbMcnxhwCs+aKRs5SjeFoE5vJckTmQ@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1qZfX9-0007MU-Rh
Subject: Re: [f2fs-dev] [PATCH 1/7] f2fs-tools: Define constants in terms of
 BLKSIZE
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: kernel-team@android.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gRnJpLCBBdWcgMjUsIDIwMjMgYXQgMTA6MznigK9BTSBKYWVnZXVrIEtpbSA8amFlZ2V1a0Br
ZXJuZWwub3JnPiB3cm90ZToKPgo+IEhpIERhbmllbCwKPgo+IGYyZnNfZm9ybWF0X21haW4uYzog
SW4gZnVuY3Rpb24g4oCYYWRkX2RlZmF1bHRfb3B0aW9uc+KAmToKPiBmMmZzX2Zvcm1hdF9tYWlu
LmM6MTQyOjQxOiBlcnJvcjog4oCYc3RydWN0IGYyZnNfY29uZmlndXJhdGlvbuKAmSBoYXMgbm8g
bWVtYmVyIG5hbWVkIOKAmGJsa3NpemXigJkKPiAgIDE0MiB8ICAgICAgICAgICAgICAgICBjLndh
bnRlZF9zZWN0b3Jfc2l6ZSA9IGMuYmxrc2l6ZTsKPiAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCj4gbWFrZVsyXTogKioqIFtNYWtlZmlsZTo1MTY6IGYy
ZnNfZm9ybWF0X21haW4ub10gRXJyb3IgMQo+IG1ha2VbMl06ICoqKiBXYWl0aW5nIGZvciB1bmZp
bmlzaGVkIGpvYnMuLi4uCj4gZjJmc19mb3JtYXRfbWFpbi5jOiBJbiBmdW5jdGlvbiAnYWRkX2Rl
ZmF1bHRfb3B0aW9ucyc6Cj4gZjJmc19mb3JtYXRfbWFpbi5jOjE0Mjo0MTogZXJyb3I6ICdzdHJ1
Y3QgZjJmc19jb25maWd1cmF0aW9uJyBoYXMgbm8gbWVtYmVyIG5hbWVkICdibGtzaXplJwo+ICAg
MTQyIHwgICAgICAgICAgICAgICAgIGMud2FudGVkX3NlY3Rvcl9zaXplID0gYy5ibGtzaXplOwo+
ICAgICAgIHwKPgoKT29mLi4uIE1pc3NlZCB1cGRhdGluZyB0aGUgcGF0Y2ggZmlsZXMgYWZ0ZXIg
bXkgbGFzdCByZWJhc2UuIEknbGwKcmVzZW5kLiBUb29rIHRoZSBvcHBvcnR1bml0eSB0byBtb3Zl
IHNvbWUgY2hhbmdlcyBpbiB0aGUgbGFzdCBwYXRjaCB1cAp0byB0aGUgZmlyc3QgYXMgd2VsbC4K
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1m
MmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1m
MmZzLWRldmVsCg==
