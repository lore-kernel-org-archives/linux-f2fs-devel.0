Return-Path: <SRS0=GSv8=PN=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE68EC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:22:35 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6617861029
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6617861029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mf2k5-0006Ra-T7; Mon, 25 Oct 2021 16:22:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <daeho43@gmail.com>) id 1mf2k3-0006RS-MZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Oct 2021 16:22:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NV5xGjeuKgWRl/AhpoxwqkehlRrug/Db58M9ZBXGaY0=; b=J8ZO06bXWhvi9YI/qiBbJ4Hwec
 ylJv5RiPn9sBFyl1w7vjVAwQcqkpuhd7KgyYyZ/WzHTWP9Ry8X6bpunGEozkTOmfPk5ESUBAWz6cx
 v33u9Ax7AJbP51jD7Tl73g2KRCEvY8RAVmcrBx8GmPPsy/TzotvYiflDxHLkxSmAykSA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NV5xGjeuKgWRl/AhpoxwqkehlRrug/Db58M9ZBXGaY0=; b=baGkcplSiPU65Z76VVPkHj3yYd
 PSdH3HQeUD14wQLqOJxa8ltgBtM103sO6++5keloDW0nz382hbnS2z5jFD4lHJbLrknHwLx0B/n82
 84xYqk5hklCYyYf0KvPs5OLCr1GQCWbkIa4UKFOf9RnQswbhqy7x13sPrW4BfcEGUoZc=;
Received: from mail-lf1-f50.google.com ([209.85.167.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1mf2k3-00Fs4z-3P
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Oct 2021 16:22:31 +0000
Received: by mail-lf1-f50.google.com with SMTP id j21so12611756lfe.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 25 Oct 2021 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NV5xGjeuKgWRl/AhpoxwqkehlRrug/Db58M9ZBXGaY0=;
 b=DxHEufieywRogdN+zRT2Fvd7AcyLJXan+k4lp9oZ6i708wTKTUuJdVkvgg7/+/foHJ
 rGDfbQuoBHCnzKQ215OYOSvUW4nAmRr3T+cHnzwRx/QtHi2W8zV/NDWEJyRy5lEji6U1
 29Hl/HibXnAKbge6wMjYtB88UZ2tUJlUkM7rToz25BGieSiK1/hECzVB9eL4QpVuQ4pE
 dbKWR1Oax2GOuFXBd0BESbEvyuJA8/GT19mYEhR6NjtzBnqIIMe4nZ+vXWuHVSIjTyzM
 qJvxy4nqC70GCi618+64IJpYylEdB0B5mmiyfYRSgBOjQpld26p5qmnLdvCyFpppizcI
 nf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NV5xGjeuKgWRl/AhpoxwqkehlRrug/Db58M9ZBXGaY0=;
 b=K0ompWlBh4/T5niiEALdP93qnnbr+sLCn4m5xaAWv9ewsQPU4Pc0fpJaZrvqGIP14A
 GXuW7C1yCIFY3b+sN5PR/G5pAH4Siia+dUxdtGyJ/x4cexTvvWDRC3VcFvIHEWL0xnNu
 OIokwGQNw+1ge+1I/BndaJEHQXEFE1x7SVLx9+aewRjXqKc/39cmG53FzZdXHT5VViB9
 dSyGfb7xDU4Ukr8EG6lDzJwqQrgzjeVa+NnDckTl+D7jId8EIOYgNGLX382YcsMG/xIm
 fWn6MIC5WJS0ONvBFOTb4tGB0XCRv9mJJOWMtZooOIiTVNqR3ONIeun61oZ+8ZkAiNde
 mplA==
X-Gm-Message-State: AOAM533/tisLcREJCUlqKWzHM4GNhg+7YNsCTh0k4rkrcbWr3cAoNgC+
 2/pt0rQtVNxRPChEisOsGDO+e7YRtXoVuR8VO9Y=
X-Google-Smtp-Source: ABdhPJyk5EwgLvFQId0G03B/U7FsCuwXAyPOZPL/tvQaV4OJEzm0ikoyJwxvaOHigrg/xqXAuIaDx9z1Bl4RI6Ck488=
X-Received: by 2002:a05:6512:1056:: with SMTP id
 c22mr18504309lfb.26.1635178944474; 
 Mon, 25 Oct 2021 09:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211014190503.717830-1-daeho43@gmail.com>
 <e8b106fb-2878-2fa9-788f-965eef179a85@kernel.org>
 <CACOAw_yupuz+Xx-z9V0UaExuARHd8H9rruWCa2yj5-mgkeuUtQ@mail.gmail.com>
 <3ddb4013-8d63-7c00-6fdd-1f21752bd60c@kernel.org>
In-Reply-To: <3ddb4013-8d63-7c00-6fdd-1f21752bd60c@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 25 Oct 2021 09:22:13 -0700
Message-ID: <CACOAw_wjhr8j=-qEDHP_H+_7cTh_ep7Wix4=JC+5x5zp-zpUFA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1mf2k3-00Fs4z-3P
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove circular locking between
 sb_internal and fs_reclaim
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Oct 22, 2021 at 8:32 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/10/22 0:44, Daeho Jeong wrote:
> > There is a deadlock between sb_internal lock (sb_start_intwrite()) and
> > dquot related lock.
> > It's because we call f2fs_truncate(), which eventually calls
> > dquot_initialize(), while holding sb_internal lock.
> > So, I called dquot_initialize() in advance to make the 2nd calling of
> > it in f2fs_truncate() ineffective.
> > This is similar with the thing in f2fs_evict_inode() in inode.c
>
> Well, if dquot_initialize() fails in f2fs_drop_inode(), will we still run
> into deadlock?
>

Do you think the same issue is in f2fs_evict_inode() in inode.c?
In fact, I picked up the idea from here.

        err = dquot_initialize(inode);
        if (err) {
                err = 0;
                set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
        }

        f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
        f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
        f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);

        sb_start_intwrite(inode->i_sb);
        set_inode_flag(inode, FI_NO_ALLOC);
        i_size_write(inode, 0);
retry:
        if (F2FS_HAS_BLOCKS(inode))
                err = f2fs_truncate(inode);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
