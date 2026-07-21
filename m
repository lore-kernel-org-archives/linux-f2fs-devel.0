Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC40C4452D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 23:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zWu8EmH2nnElXjiRQW49PoIMdIR4/IOUtu3dspMpZzw=; b=HHKdh198ihX5KE350U5JstG8Kt
	WjFB/mLZWvhjDOQ7vJxjhrIOhJJE7g/4IfwRUeOxfCPfwa0KosQtCjXgwWwbhfh7LIGneqd5BsmuN
	DDOZWZGyUqjShXzOzAgLQzCwS9ptinhmQz2PrT2RLOUuvOjshXxTtdjDLKKOMEjcqabQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmKKL-0007CR-TL;
	Tue, 21 Jul 2026 23:56:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wmKKK-0007CJ-N0
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 23:56:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qyvSwR8kTyehc1+zjPruM+M/dAC6YJuL0NpDJdvfp/A=; b=H0/3ICKFh5scgr6jd5+68Zr19r
 18x7poTGZUXBlmQZJcYFIT+t16n0MQRUiUVYjBceoby1irUEWx9h2Iz4AHdKfwq35phFC7LMnhoWu
 /o9UNcl7bPO8hhYYme5+aZIjDlFiKYNU50iTJyHBRdHEzEis5Lbh8LUPQhw74obLPCTg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qyvSwR8kTyehc1+zjPruM+M/dAC6YJuL0NpDJdvfp/A=; b=LXFUCkkhSIj+vgNbbhTKOap7BE
 rKWq8bwMjsvDIYU+JKisXGqhZ8Y9mTQvRZb1RGHK/utHfcf6TAo/apwIGXV4Z9JJ3rN2xdCzoHNXV
 CvMNqwtNTmJyATANv7dK7nXUXC1Kj8FoMlCuYKGkDDuleD6xFkY86mDF40wzMYTL3JXo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmKKH-0006dr-QI for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 23:56:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 56DC640E8A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 23:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A661F000E9;
 Tue, 21 Jul 2026 23:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784678196;
 bh=qyvSwR8kTyehc1+zjPruM+M/dAC6YJuL0NpDJdvfp/A=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=FaYCmKT1GS9xfmEt7bTsprTluroGYxVL4Dy+TwZXYrTJyqwXOYJiKv4LEDLxVW2Gh
 hp+pxpeHgdJyJVCQBuJBqVbQNSA2fyZn5Qg4IiWt2vIdVxWwnSFFf8rIdboxnpDvvm
 PygL4rrLqexE4qnAdt6NFRexLR+iCLvoAXRaICaDTDx1RotmXQfOLbbQS0i6OCR8Nd
 XZ9kgFzoCd2anNnsPHNhVSc0QhS3IUEetCBA/xL83oQBZMaNRIh2hAJafFFkPI4t/v
 7EfSvsdk8/o9x4y7PkfJjFTSlmt+PFeflczqfq7cfEbPpeKNjznz5kAqSRgMB8zZFi
 i7w4alefqcnvg==
Message-ID: <3d872ecc-6e76-43b6-8b43-adb979cacf79@kernel.org>
Date: Wed, 22 Jul 2026 07:56:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@kernel.org>
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
 <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
 <aloCfjjqesxpzL9z@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <aloCfjjqesxpzL9z@zlang-mailbox>
X-Headers-End: 1wmKKH-0006dr-QI
Subject: Re: [f2fs-dev] [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
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
From: Anand Suveer Jain via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Suveer Jain <asj@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


> Hi Chao and Anand,
> 
> The *_fs_sysfs related helpers were brought in by me in:
>   commit 2a7b77abcd1dde735186b363da24540706c43b73
>   Author: Zorro Lang <zlang@redhat.com>
>   Date:   Tue Jul 5 17:30:24 2016 +0800
> 
>     xfs: configurable behavior on errors at unmount time
> 
> At that time, I didn't think about the "features/" directory.
> 
> Now, let me rethink this set of helpers. I feel that the *_fs_sysfs
> family of functions shouldn't be restricted to the $dev directory,
> we should remove this restriction.
> 
> Following that, we bring in *_fs_sysfs_device (appending the _device suffix)
> helpers which call *_fs_sysfs(). Also change the test cases who call these
> functions.
> 
> Finally, we can introduce the *_fs_sysfs_features functions (or simply use
> *_fs_sysfs directly).
> 
> Also, we have both *_fs_sysfs_attr and *_fs_sysfs, and the logic between
> them is somewhat confusing and easy to mix up.
> 
> I need to write a series of patches to clean up these logic. For this current
> patch, we can start with a small-scale change first. What do you think?
> 
I noticed some duplicate code that needs cleanup.
Essentially, I think we can maintain two sysfs check helpers:
one that involves mounting the device, and
another for module-level feature checks.

Thanks for the help, Zorro.

Anand


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
