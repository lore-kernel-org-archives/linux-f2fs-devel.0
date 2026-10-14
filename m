Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D64CC6B27
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BVG6aJuE+uhNNixiR/ejx6QJVAf3CwjpoapRK1SMXEw=; b=KSOFL4osqzAW9mvdpkW9aCKCAK
	ebIKcp9CqMCJaWb3V9vOIpPoLhrubcOeSUMJyS6Gaj3iLzlTPs+VkaKwhBTMPG/GtgjLUbOUzrCdz
	3zbeXGKUAF7Al6apkGmFtIkBevTaudhJ7ytFI7CzQsJ+vW6DGgPk0vGaHa1S1LL29NdM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGuXw-0004yE-FR;
	Wed, 14 Oct 2026 08:41:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGuXv-0004y7-8W
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 08:41:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4vWQMegIv4P7Jo1ssSH5rXG9xf/7rOxaSIigCU+dK1s=; b=AnegEUW5iIg01yGOeGFzub88QW
 lcOJc7Z2E55w51KFP4g20YtbBILte3828h0jvKfGGAmRLl9+8n2LxtbqiAk4M5rtTAxmjWvkt5h9C
 nyPdI3uKMDJZIFUtSTFgBAUOmprHYhjp2BRCT/dW0BbND5nNdN4lM+aihud6GJIUo0V8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4vWQMegIv4P7Jo1ssSH5rXG9xf/7rOxaSIigCU+dK1s=; b=muW+9kDPrBQxHKdjFDO422w8yX
 OLWuWSTrF1YK54OUEifxZV+CD1GasgcYSM4+DjIVEyfG6JFUl84Mf3i+PtdNOOcwBNeJmyQQ/QmK6
 yagKA6DTcN5ebJZbk5a7erbH53cMIoTQULUqm/S3d0oLrsR9cvpS0B+yOxxOnHA6vLWM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGuXs-0002Ey-VZ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 08:41:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 07E0660213;
 Wed, 14 Oct 2026 08:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DDD1F000FF;
 Wed, 14 Oct 2026 08:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791967262;
 bh=4vWQMegIv4P7Jo1ssSH5rXG9xf/7rOxaSIigCU+dK1s=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=lQuG0bZFKZRt5XH5C7I4H45cuslDl+TRpNucmf9Slv6jW8S5hd+dsxuqiwFaFGvJl
 RlzdwNgCr6AtAYqWzekJmwy3K77oeDKQNwbSpMSfJRjbrRAuculz0KQXvPB6NSON9R
 ie5AHfww1dEZ+tdAkcFdBTCEH8NUqN7Z6qNGyUFi804aBzXKJ/f4swNuMMp1DlXIW0
 rsv9paxry8pHnvLiTC6fyHYNkDgwfCuoiIkeLNINbz//q3aks9yukTmJNOYNUWmH7g
 OSk6QzAJQBXJE4fQQOf+muNBt/2uF7REhv3UJLxTRyloRfzCse1GY8OrnK4iM/G1kD
 CoImRDSJxdnkQ==
Message-ID: <5a696e66-f0d5-4a8b-8925-5efb3bff8e62@kernel.org>
Date: Wed, 14 Oct 2026 16:41:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jianan Huang <jnhuang95@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
References: <20261012025442.770777-1-jnhuang95@gmail.com>
Content-Language: en-US
In-Reply-To: <20261012025442.770777-1-jnhuang95@gmail.com>
X-Headers-End: 1xGuXs-0002Ey-VZ
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: quota: fix quota flush failure
 during filesystem freeze
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/12/26 10:54, Jianan Huang wrote:
> Quota flush retries can be exhausted during filesystem freeze.
> 
> freeze_super() and the quota checkpoint may race as below.
> 
> freeze_super()                       f2fs_ckpt
> - down_write(&sb->s_umount)
> - sb->s_writers.frozen = SB_FREEZE_PAGEFAULT
> - sync_filesystem()
>  - f2fs_sync_fs()
>   - f2fs_issue_checkpoint()
>    - queue CP_SYNC -----------------> - block_operations()
>                                       - down_read_trylock(s_umount)
>                                         : fails; freeze holds write lock
>                                       - quota flush retries exhausted
>                                       - set CP_QUOTA_NEED_FSCK_FLAG
> 
> During the PAGEFAULT sync pass, freeze_super() holds s_umount for
> write, but umount_lock_holder is not set until f2fs_freeze().  Thus
> quota writeback tries to acquire s_umount again and can exhaust retries.
> 
> With checkpoint merge enabled, f2fs_issue_checkpoint() may dispatch
> CP_SYNC to f2fs_ckpt. That thread also cannot acquire the freeze lock.
> 
> Record current as umount_lock_holder around the VFS PAGEFAULT sync so
> checkpoint runs in the freeze caller and quota flush uses its existing
> s_umount write lock.
> 
> Fixes: eb85c2410d6f ("f2fs: quota: fix to avoid warning in dquot_writeback_dquots()")
> Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
