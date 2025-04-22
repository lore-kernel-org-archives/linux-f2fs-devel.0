Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F12C369D7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:07:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u7FDm-0005Gc-Ik;
	Tue, 22 Apr 2025 15:07:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1u7FDl-0005GS-KQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Apr 2025 15:07:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=puH9qIzvRTmk6NMn/K7232hqU8zQS4VxkhYiI763HTE=; b=S35/xjDj2n2BztFo/ZJApzrJzP
 Wukuo0tXxyBOhyqUo22uBsEi7ZcgwFr3Aa3pvAtNWYkKuV2eZ4UpoY7AD7mN07VYUlH4bnZPrfBqT
 9TtFsZAgrADGvAo0zH6Ytlbqqi8ERA/BM9N+Xd7C86+v9mTM+0vqf2wN7omKUkFAJwRY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:MIME-Version:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=puH9qIzvRTmk6NMn/K7232hqU8zQS4VxkhYiI763HTE=; b=O
 +rvKQUHRTHJc3ViLVKQB0K2FTVyljb+bZHvEAPV5Bn04GSu5cSQm8RnEUS2JCR2WmMvTgtsZ7fQuh
 XiBxoKq/6fuMgRf05DZmic//VtN61ZxKRqSW5zmzNO1Ds9yfGj8gMBGJQWXeXi0aT8wMSM7bJyda5
 SvMONtTK4L7V8m80=;
Received: from mail-oa1-f67.google.com ([209.85.160.67])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1u7FDW-0001Gp-Ma for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Apr 2025 15:07:38 +0000
Received: by mail-oa1-f67.google.com with SMTP id
 586e51a60fabf-2d4f832069cso2255069fac.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Apr 2025 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745334432; x=1745939232; darn=lists.sourceforge.net;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=puH9qIzvRTmk6NMn/K7232hqU8zQS4VxkhYiI763HTE=;
 b=L8jwzwqAsksU+3WZzY6PYxw6YzrXVyiXPJCHOtolH7CgV33t2B5Yjn6S8FRsZQHjnj
 qLgwljI255kA5TS7naFhfUj47POUpCYnzdccSdlfoWgK75C0PYG3wRPHBTFO192fcpRo
 XbAPppd4fH0oA3soU4pPFc9cwJswBjHx5FewzAsF3U/z7L43PR/jmRH5d8GM88oyOw4c
 d5bJYDYCf7mqb4Gt2e12gk73j1YGMFiFRqyIKYJKhmmud8HtnRUdNRk4WereJjKB+wA+
 Ebd9HeHbc4RqVUr9MJeNfG7iiU9RCclUVNWhp8kpCHOB2z0D9FpnXRIUoWmuz2mm1XUG
 /fxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745334432; x=1745939232;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=puH9qIzvRTmk6NMn/K7232hqU8zQS4VxkhYiI763HTE=;
 b=ps23B94QESmo3ZnClePMqTSDHncvysmjtxSv1uY0VgM+LXn9DtSAON7K/Euq73P5TA
 +UdhnWM89BqoEHerHSKoeNONqONuiRktukFgmkcESXNoTkGV8FnZ2SatZ8hklmnmkiKr
 vk34bA2hqUr19ZX0gEuv0cGYduh7f1/LY0cPu/E93ZHnzOlgWFnsJxK+G7d3471bOhXm
 TvfGPgqaO4P2UM2YhgnFiUomcAj7Cr3d8VoHka0zGnycThpx6h/BeBYLKK42UDNgUeig
 qNSj2CSJXmLMcW2GN72XbDvSNGNSmUDc9qBmSDn3/fVxpE8nGVU/IN3XWUB9XcEy8Xe6
 +E9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqw/hEo6ncbjVJWIOm87357o3PG+11Ay8JG9H2+7VvdZEAztO5Wc7ArJubLTiUhJFrw0Vl6G5WEQU6k+zl9zPT@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyKM6pyosydifkmeg3FIuU3fIMb0sI1gCPKvwiHaE2OF7D8Vuw7
 iYPPD37KAfaiN5IAtKJZRjMlSEMbZgh9d3PtXRxsTG4ljToMGIhTfPa/hzAwQ2jn3UJ6F2SHiBA
 Se/6FrKqnagG9PRT1tnYyRMWIiG3kmY3/0DvU0g==
X-Gm-Gg: ASbGnctCKJ+1Mt3dpTiDaxP98a1uIwzIXljjakQuzPq9twcKeLb/prTxDMRWgwetT/n
 6soM6xdlb7Fsm+rlm6BR8Tvc4wK0jcdwnHI3lbdQd/aW5jS8jgaKRuDHgUrLYX08/xn86N52QFT
 6Ky82qGuiFeZMHFpYADLsKTA==
X-Google-Smtp-Source: AGHT+IGTsk8lxoKou4Ltu2Z6lx5B/MEUCHsnpDapSM/pM71JODkfUX/pyxA4bm32UA4Vd1tBIfiRgXM2LFobtoAtieM=
X-Received: by 2002:a05:6870:1b11:b0:2d0:4a2c:7c22 with SMTP id
 586e51a60fabf-2d526ae9243mr9006299fac.18.1745334431822; Tue, 22 Apr 2025
 08:07:11 -0700 (PDT)
MIME-Version: 1.0
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
Date: Tue, 22 Apr 2025 23:07:01 +0800
X-Gm-Features: ATxdqUHvLVCqANVXieQfOfT0KSw8yaux35t85KAyVvUIKGIGemnUscUEboKooFI
Message-ID: <CAMLCH1Gg=dbzc1z82D6SdrrHRNca4K3vWdiZ+6O+J3nbZ52Sww@mail.gmail.com>
To: Matthew Wilcox <willy@infradead.org>
X-Headers-End: 1u7FDW-0001Gp-Ma
Subject: [f2fs-dev] [DISCUSSION]:Chanllenges encountered in converting page
 writeback to iomap
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
Cc: "v-songbaohua@oppo.com" <v-songbaohua@oppo.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Dear Matthew,
Hope you are doing well.

I've recently made some progress in enabling iomap support for
buffered read and buffered write on regular files in f2fs. However,
I'm encountering significant challenges when it comes to supporting
iomap for page writeback.

Currently, the f2fs_write_cache_pages function is indeed aware of
larger order folio Well, its implementation involves setting a
threshold, collecting a fixed number of pages from a folio on the
stack, and then submitting IOs page by page using
f2fs_write_single_page one by one. In other words, this results in
folio -> page -> bio IO path.

My understanding of iomap's writepages implementation is to treat a
folio itself as a complete IO unit, rather than breaking it down into
pages. Within the iomap_writepage_map_blocks framework, we consider
both the mapping length returned by the filesystem's
wpc->ops->map_blocks function and the dirty length within the folio to
determine the final map_len. Then, we directly add this length and the
folio to the bio, thus forming a direct folio-to-bio IO path.

However, for f2fs, the tight coupling between its unique IO
information structure, f2fs_io_info, and individual pages presents
several challenges. For instance, f2fs_io_info stores both the old and
new data block addresses from the dnode_of_data of a data page. Since
f2fs employs both inplace and outplace update mechanisms, the old data
block address becomes unreliable for write IO during outplace updates
(a problem not encountered in read IO). This poses difficulties when
writing back an entire folio. If we were to use iomap_writepages,
wpc->ops->map_blocks might even need to differentiate between blocks
within a folio that require inplace updates and those requiring
outplace updates, and then split the mapping length accordingly. I
feel this would lead to complex and confusing code. Furthermore,
f2fs's current bio merging strategy considers not only the contiguity
of adjacent filesystem blocks but also whether the io_type of two
f2fs_io_info structures is the same. This information would be lost
within the iomap writepage framework.

Intuitively, I do believe iomap's approach of directly submitting a
folio as a single unit to bio is very reasonable. After all, a folio
contains sufficient information to do so, as it holds the logical
indices of all pages. However, due to the aforementioned issues, f2fs
currently has to decompose folios into pages for write IO. Moreover,
if functions in GC and page cache that perform IO also aim to support
folios, they might also have to resort to looping and decomposing
folios into pages.

What are your thoughts on this issue? Do you think decomposing folios
into pages using loops would violate the design philosophy of folios?
Or do you believe this approach is sufficient for f2fs IO? If we want
to move away from this decomposition approach, do you have any
suggestions?

Looking forward to your reply.
Best regards.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
