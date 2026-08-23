Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50500C5DF8C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F8cKmtqmMA2IMNutsLtQWuz3TS9LarEO/TBKaJ+ZTik=; b=fNrI4mZWsE8Q5MaAk4641yv6OO
	NDVEGv1AdoBuq+3m1U5R3dfvIAZdr0K2znMpZDmb85PQrBjqQukYmP8ihQqVSc2j8uNm9d6S0ymp9
	TfBDlpaJi5ojJ+WPtURII0+0joyomhZkmd8ZFb4iH+mL6EHLJsSn6IfOtD9pbnAwFHqA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wy7ng-0005Gl-4c;
	Sun, 23 Aug 2026 12:59:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wy7nF-0005GH-6B
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 12:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u/y9QLwF0CQ2JunWN64oK2Ck4jB+nqx322E6+yVRiVk=; b=HmKHDSqjY/NVhKhx//TOkF4LfS
 0OeEe1jpje6Ia7DmpdKO6D7giE9119Cnz/BzPSrpfI6wmopaR/eN3bQAmIV0SMDdSwIFdXHIxfDeF
 maObtmQPvZNj/WrQ3BxmAfZarUUFNLw50ZJYnuQdhBzfg2YE6NdXSRIVtNHO5CHSPW0c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u/y9QLwF0CQ2JunWN64oK2Ck4jB+nqx322E6+yVRiVk=; b=K2r+JKL6HYsEgWuEoW7q57I+yC
 fU0KWyvdfKKzj76TZPcI1xa/tfFKVz/EUbflv5W3cuRwHnGMQAGwUTKrlzopZ4nyXzilOXzUmMc/V
 AJjvBuHalfiTUilD1K/D148pGiTo5usnoTTQfCc021/0pd+PwoxxDdeInI5SZ0mCaT/c=;
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wy7nF-0007Be-HM for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 12:59:21 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1978517a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787489956; x=1788094756; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u/y9QLwF0CQ2JunWN64oK2Ck4jB+nqx322E6+yVRiVk=;
 b=tNeRjKPZggjQEyQiTGNXatcA5uYbDzPSEv3RD0C87Dh3fwc9uoFWhkFei6ZhzRk/ur
 Ol7NILGzvJmc+2tsVL2eoR1baFnWlrY/ZmB2FbSpyvEG6w72Ryg/j7KykLYJnZAhgx3U
 q6ktBxUuvJTvEv2bGyfVzmm6ZYGdtFNl3zMcjnpMTIBm+kg7SjM0gdYF5KIraQi5et1p
 e31iZxR2pJ7je4rndgQvshaQiAGS6pf3eeihK1y3ZIqcw4+0M7KlSQ9aG0iifhDOGnmh
 VQ4RfaINPh3YQW4QawdaLG2GXEVJ4PwHZ3mD5ny/t3pb4x7TyhcvlWN4EIVHjKs7Igdp
 5jLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787489956; x=1788094756;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u/y9QLwF0CQ2JunWN64oK2Ck4jB+nqx322E6+yVRiVk=;
 b=EAAa4R+b5guWyend75phEdQAcLSbYNK8E2hFS/isKEWJc+bqgWdlEso5s/15uxuUhh
 n4CGS1ke1Lx5pNiTz7GcsSJwOl1K7YXaPBIqso5MogQIf694x13Q5LW4LuqnLeEc7aJo
 hsYOMiL6Y2zSXBav586uOm4r5Xd0BysBjZcbRZATjwfrIsli/2sEGl8mkxwcptFSacRt
 wCHVHrdrgQQC1otFrfGyK9kBZmSMb12aWHiZllgLuhS16icDPH8cAqbZOcyFdlOHIeg1
 LduHd0mJj+r5L3biwkrMN1JnkF3IEomCYdZcROZboWR5O+NmV8fV4nH+yAqf0XxlgOd4
 mMUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqI9f26pX7i7Bx+2OVXcF++1im51Z/z5RHUYv4Y2HZS0BT9nis2Fg4WqBmYlpL4BppdDp4B0CvCM49/qtlPu2Y@lists.sourceforge.net
X-Gm-Message-State: AFuF++nmE6i2IcgbtPUQweRMjzv9F3nPQVXgdHWT7LgA6pX6mOb5AD/x
 hJmoggnNfYDA//uDR9Fj11cmNDJR0uYox8GWdOuLrZFnkX4yQV6eR7Tc
X-Gm-Gg: AR+sD12Z1DYpMytcVk9Lin4Yw2WlV9komE7JcYCoXz/NqdsL0pFDllVHqenilJZnWxx
 DkETFfTN9HA+FEdmO928+WbftFfGL9a8xKnE7mbM8jsxSe+jSqCR/6Rf28OHVyYU0tgqmcaEFcc
 /6iZY/e/mrCUJ4pWCIDlG2IIlxoBqzgmNTWkH2U4zEgpaRdPIE+CHfACtj0xpzhxKIEWlFSxjRx
 NifUXleK9gfZpHds9nqlxKzqeIsbvbAkAHZsxje4nkp9SUnH/bVFYiKnld8FUMaGC5rXrl2NiC5
 1RYVxo3JksWJMjbxtYm5GdTKqxpaTDCrMbxVIrFVEkitBaWNO9J+pVJNuJRf+/eaPXqm+M0CaCn
 J4qn5NuH4rIbjT52C2SB0n3cQkv0galxRaqeC7gZB85RsAH461oP08tlMLRQmGE7iCeV1c4JZMv
 3GX5IpNsjFiMmjBN1IUL83lJnEtvMVNUdltEJ+s4L2EQ6EiAqqthxFFisc3AIIzszMtqv8hH1LE
 B2w09HtRSRjZrvvXoUw/0Qb
X-Received: by 2002:a17:90b:1b0b:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-395c35ac458mr30602577a91.6.1787489955733; 
 Sun, 23 Aug 2026 05:59:15 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4a4e5ecsm6113820a91.16.2026.08.23.05.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 05:59:14 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Sun, 23 Aug 2026 20:59:08 +0800
Message-ID: <20260823125908.3231362-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820031721.12218-8-chao@kernel.org>
References: <20260820031721.12218-1-chao@kernel.org>
 <20260820031721.12218-8-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wy7nF-0007Be-HM
Subject: Re: [f2fs-dev] [PATCH v1 07/12] f2fs: cache: use node cache
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
Cc: qwjhust@gmail.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Wenjie Qi <qiwenjie@xiaomi.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> out_err:
> 	f2fs_clear_cache_dirty(entry);

Both the inode-checksum and footer-validation failure paths reach this label.
`f2fs_clear_cache_dirty()` clears the DIRTY state bit, but it does not clear
UPTODATE or synchronize the DIRTY radix tag and dirty-node counter.

What invariant keeps these states consistent after node validation fails?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
