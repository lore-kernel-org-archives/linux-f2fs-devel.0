Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0081ACDB470
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LQQrYHJYdtRQsfyLY0imUI3BZB3eaUAsB0hOqQvjiKE=; b=lsttLYLghbHvaB8aW9EA5HHj3Q
	cgAoGhnYlIMgxEdJEHq4WFsl1kkQEapuLHUNhrddBPXptzyPbMi+RaAADedPIhrXoZbpuSakevSHU
	BInjf4u2dPxA3o0RHEyQN0cGbDkLLGcfCRnS9jfhsG06nRSYr11BlK6uc3TsvVunsFJ4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbumc-0004QN-Tl;
	Tue, 23 Jun 2026 06:38:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wbumb-0004Q7-Hj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 06:38:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AZWDb6IeOrOj74EeRXqPcDcvK6g2drp7a/Cr1Fkr8gE=; b=HP1ZBSuAIl9A3ii3VV4KuwIAIH
 z7w42+w/XjZ9R3si08fgUpSZiXWxvPn1KFbGx6cd7MtzX4pv1w3MYhk3meSrSefwQ7hggMSKXOuVF
 ZgX7K5w2Mw1h6abHANuMzad11Qyf0ztpo7jMdijY6vg3vGTmlMYsFSG/Hyo3DOzaohCk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AZWDb6IeOrOj74EeRXqPcDcvK6g2drp7a/Cr1Fkr8gE=; b=T/nV3hR4LHdpp9SfOvBgHnhavM
 dzV4qHM8DqHFZ5oLMZR26ZQzCmoIYFDyjwTxi632u3BptimvbGwyRBx58YRhdpEetBKE+gVlWp40T
 o7ejeGCDOojtlYjyhr7Q1dQNBEKsGQqklKn1gsg6U/oGhCL+ORKp9aMvQNRTRl0v7m2Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbumY-00053I-R3 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 06:38:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E31164019F;
 Tue, 23 Jun 2026 06:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9AD1F000E9;
 Tue, 23 Jun 2026 06:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782196725;
 bh=AZWDb6IeOrOj74EeRXqPcDcvK6g2drp7a/Cr1Fkr8gE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=iYiEzcMcfi/Na3EuA4mMeUgBOgfKeKMMAgPp3YDWIx+BwkMVnDp+0ILESuyhZblvi
 uftyzMNgCfs04Ojl6QLv066M2f1HDYl9GpwUL36VmSt41+9/5DCy/kU1CG6HladTAL
 cPekegzkX6+M+wahN6aH5fVW8tlMlgnuW9VNK3dOAitLXYdxdSsRLOF+DIYsJfe+UV
 d+2ezGRQyvKTfhgSP0S+bDfMhplC3B3Ns9yY9VgjH/bz/SH9/hqrhwZJ/w9OFeBjhG
 RIFUGABg5Yxx6CZ1Vh1dlmGMvJ3lruwb6pBkUCE+1WqD+Zz22+eH5uDfL6b57VfiyR
 7wtQO0CoLvl5Q==
Message-ID: <2b98ff5d-e66b-4c31-b718-000eca3dd467@kernel.org>
Date: Tue, 23 Jun 2026 14:38:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Joanne Chang <joannechien@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260623063428.222361-1-joannechien@google.com>
Content-Language: en-US
In-Reply-To: <20260623063428.222361-1-joannechien@google.com>
X-Headers-End: 1wbumY-00053I-R3
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: dirty directory inodes on
 mtime/ctime update
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/23/26 14:34, Joanne Chang wrote:
> Xfstests generic/547 sometimes fail with mismatched directory metadata
> before and after a power failure. This happens because when a directory
> entry is added, renamed, or deleted, its mtime and ctime are updated and
> the inode is marked dirty via
> f2fs_mark_inode_dirty_sync(dir, sync=false). The sync=false flag means
> the dirty inode is not added to the global DIRTY_META list. Therefore,
> subsequent checkpoints skip flushing these updated directory blocks,
> causing directory timestamps to revert to stale values after a sudden
> power failure.
> 
> Address this by changing the dirtying parameter to sync=true during
> directory entry mutations and renames. This forces F2FS to immediately
> queue the updated directory blocks on the global DIRTY_META list,
> ensuring timestamps are committed to checkpoints.
> 
> Fixes: 7c45729a4d6d ("f2fs: keep dirty inodes selectively for checkpoint")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
