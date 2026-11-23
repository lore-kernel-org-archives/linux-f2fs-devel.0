Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD75606A331
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GyS67qjk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Hq28jy5i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AdogTHgz;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xnq9a9ZK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=k6xXyH5GUCbp2VH136gkSYiCAKEDemDWaxjwzDx3DGw=; b=GyS67qjkHml2c8Una44hCEoNc+
	UAguaT4ywe0j10qz3FfmVzxADzMUm1KsXhLq38TauVMNIp64uJqSmysRZ3mSW/oZ/ZonQ7H4uOZwr
	8xyPwdtYKv010rwsYzmrI53XXvN1Sfl4/pylnhxmzCJ570FpqA8NnumBR5S7NpHiV80w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZKs-000000004My-1jOW;
	Mon, 23 Nov 2026 19:04:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZKr-000000004Ms-3v6z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 19:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NMWwVWVTeHtMwupcRu9IpvymnFnmUx86vHQQ3BkUYBg=; b=Hq28jy5iVBPZVc5qmCbSA7snG/
 FvagqAWKXDa9OkNkJdVT/60kQa5IZVyhiOJmnl1V0mXjVqRKsF5+DIHH0s3m3id/EfC4eeirZ9x2G
 d6Ff5/R7AYglBn6B5vJfCOAZS6UxYMZDr50N6wxbpQ5cq1eiAHfHAzwdOB4nEJkyKO0w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NMWwVWVTeHtMwupcRu9IpvymnFnmUx86vHQQ3BkUYBg=; b=AdogTHgzisYGGb3/L6ZC+vrfYn
 F/RePA3KzWLBbDIQIF5mNjFk84V5UY3wBg/XzOJdDo5/BWOzZtE8jcC90Pa7yzitVmyHDhZy07loi
 MuNXdswwdFXsJO7Ku4GhPR/RC/MNaDONAiyFPe5vkiMKiNKICRHhy9eDXDXUHgIbtUE4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZKq-00000000481-1zEi
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 19:04:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC66C60E78
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 19:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5E51F000CA;
 Mon, 23 Nov 2026 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795460650;
 bh=NMWwVWVTeHtMwupcRu9IpvymnFnmUx86vHQQ3BkUYBg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Xnq9a9ZK11s0SNmAZ7xgEwO0fh7NeyaapEmNP9kc2H9GMrqUBCMoNs8QWoEmOQJK/
 i0TBTHJT9x0IcCRDJkZicqbGHLtigw1i8dW2xpBtrjKxQ0SALBOqi2FPMtuydS35bC
 M+4RDld7/WsryBfUMBbXhAhFdlBGe6FRJTxcVmMFTUwD3foLAAc2ALqA6xXu4Gj+WJ
 X/xxJdZgNDnxAHeIg87nPZ30q6s2bcJLCHzITep9njS3B04kLVUOUp5Orkqm17a4ks
 WWKtuD0fSrVxnBY/t3k/ajG//s6uLoTBq7lSOlxjhxVa4vMKtA9lbnPykCMvZ9Tnvk
 hFP/CHPS8f0Jw==
Date: Tue, 24 Nov 2026 03:04:02 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSNZ_Zn4tAT-xYS@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <98450cf50f0b962f4b6c2b0a16ec10c47362bccd.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <98450cf50f0b962f4b6c2b0a16ec10c47362bccd.1791272793.git.asj@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVZKq-00000000481-1zEi
Subject: Re: [f2fs-dev] [PATCH 11/21] fstests: verify statfs f_fsid is
 derived from the filesystem UUID
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 06, 2026 at 04:55:37PM +0800, Anand Jain wrote:
> On btrfs and ext4, statfs f_fsid is computed from the filesystem UUID,
> so a filesystem created with a known UUID must always report the same
> f_fsid. Userspace relies on this, for example fanotify and file handle
> users that identify a filesystem across mounts.
> 
> Guards against f_fsid changing across kernel versions, which would break
> userspace that relies on it.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  tests/generic/902     | 38 ++++++++++++++++++++++++++++++++++++++
>  tests/generic/902.out |  2 ++
>  2 files changed, 40 insertions(+)
>  create mode 100644 tests/generic/902
>  create mode 100644 tests/generic/902.out
> 
> diff --git a/tests/generic/902 b/tests/generic/902
> new file mode 100644
> index 000000000000..44dd685a887b
> --- /dev/null
> +++ b/tests/generic/902
> @@ -0,0 +1,38 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
> +#
> +# FS QA Test No. 902
> +#
> +# Verify that statfs f_fsid is derived from the filesystem UUID.
> +# Create a filesystem with a fixed UUID, mount it, and check that f_fsid
> +# matches the expected value. Applies only to filesystems that derive
> +# f_fsid from the UUID (btrfs, ext4).
> +
> +. ./common/preamble
> +
> +_begin_fstest auto quick
> +
> +_require_scratch
> +_require_uuid_based_fsid
    ^^^^^
> +
> +_fixed_by_fs_commit btrfs 72de4807ba84 \
> +	"btrfs: derive f_fsid with dev_t only when temp_fsid is active"
> +
> +_scratch_mkfs_uuid >> $seqres.full 2>&1 || _fail "mkfs failed"
    ^^^^^
I noticed this function supports f2fs, whereas _require_uuid_based_fsid above
doesn't. Since both functions are introduced in this patchset, I'm wondering
if you intend to run this test case on f2fs or not.

> +
> +_scratch_mount
> +
> +blkid $SCRATCH_DEV >> $seqres.full
> +f_fsid=$(stat -f -c "%i" $SCRATCH_MNT)
> +expected=$(_scratch_expected_fsid)
> +
> +echo "f_fsid=$f_fsid expected=$expected" >> $seqres.full
> +
> +[[ $f_fsid == "$expected" ]] || _fail "f_fsid mismatch"
> +
> +_scratch_unmount
> +
> +echo "Silence is golden"
> +
> +_exit 0
> diff --git a/tests/generic/902.out b/tests/generic/902.out
> new file mode 100644
> index 000000000000..e20395365cb5
> --- /dev/null
> +++ b/tests/generic/902.out
> @@ -0,0 +1,2 @@
> +QA output created by 902
> +Silence is golden
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
