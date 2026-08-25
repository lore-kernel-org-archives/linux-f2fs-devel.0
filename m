Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AAEC5DF9C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 02:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xl/uTP6XXCDw3MH3oUp8d+X6p+gNb5MkdK0xRSh5Uww=; b=B7iQ41zGUt3dHAY7N5QFMBjEpO
	qhTCNbW6BiN1bwtU4o9czuF1s1V2QJThkUZgAbm1QsoA18XvP8eYymK1ZcuMw/CVh7AA+ea+RLOBy
	iOAHsFGg7MgERbGKcfdoWc4RnSiL1MDV5ZJgnv18zx1JlxWxN4VmfHholJHXi8Y7q3B4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wygis-0002R9-ME;
	Tue, 25 Aug 2026 02:17:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wygij-0002Qy-0D
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 02:17:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JaAYopV+smpZ/PTT7dIyy5UDYcqaHAGEoeEaFiVVvcU=; b=B4vw3Bvt5ddE+EbYvrz46bUAIW
 sJ7vS9sYB6ekACM2L0P8AAUMD86MO8NRj1Wgfia0sEWin1dwFx10pd9htC0HxdkQuRyNAtDhF1zBv
 N/lczgZr0CO8e0NTVFIXMmxU7ridpq5168MQNYB4ve7NwS4eVtSgA3+GZLd5QtDjRAhM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JaAYopV+smpZ/PTT7dIyy5UDYcqaHAGEoeEaFiVVvcU=; b=eitHj5Qql9UH/5/nf2qIAyrgta
 A2UpIoNYdDLxYWSZWdPm7Ki5qMe53WUQi0ISWig0IKSbVT2ds0OOsc9dSzxA1pYzzDFFBGAYy18qe
 GOjLhTxNsTT8DdK04hI9qqBtHn+rTanCUREDydp3vLflGsxiLoz2ui5BZ1nsQ+8stJ0g=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wygii-0006SN-8J for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 02:17:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1240B6013A;
 Tue, 25 Aug 2026 02:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04321F000E9;
 Tue, 25 Aug 2026 02:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787624213;
 bh=JaAYopV+smpZ/PTT7dIyy5UDYcqaHAGEoeEaFiVVvcU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=C5vQETZk+dZhFSxK6Z7kMl6dZ1fJT55+sY+lnYbNqX7kouBS8dj02RAX02WiliOvG
 +jbZQijhIdO7/JB6q//9y1zLgpbOR2uGQuGALnzFZoXW4HVs6oqTWNVmDooWBubCpB
 wctSKpetc0OEXzhU5Ui8xJ/AegkTX3irggGmLhTtF75hkO2pobe4cFY2NAk7JC7Uyc
 twAmv3O5Z6RHeMS2ycUvGB8OYxaYQrcyiYCyVFOIxug/ndfPdBhXQlFhBNcYbHjCfv
 DkfkFS/A7PAfICH6GvbwKXomSMXbJpqfxnHGUQjH41AV4qlWx6mSsujG/bMJLRyTYi
 nT0TZazqIzyfw==
Message-ID: <73847857-2460-48c6-9bb4-343f043c2b82@kernel.org>
Date: Tue, 25 Aug 2026 10:16:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260825015303.2082221-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260825015303.2082221-1-daeho43@gmail.com>
X-Headers-End: 1wygii-0006SN-8J
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: accurately adjust free_sections
 during free_segment_range
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/25/26 09:53, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In free_segment_range(), MAIN_SECS(sbi) is temporarily reduced by `secs`
> to restrict block allocation to the safe remaining main area while valid
> blocks in the truncated range are evacuated by GC.
> 
> However, FREE_I(sbi)->free_sections tracks the total number of free
> sections across the whole filesystem. If any sections within the
> truncated range were already free upon entering free_segment_range(),
> failing to deduct them from free_sections causes the filesystem to
> overestimate available free sections in the active, reduced main area.
> This leads to inconsistent free section accounting during GC data
> migration and can trigger unexpected allocation failures or assertion
> errors when space is tight.
> 
> Fix this by calculating the number of already-free sections in the
> truncated range, deducting them from free_sections upon entering
> free_segment_range(), and restoring them on exit.
> 
> Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
