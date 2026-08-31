Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B82C624A5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iVaYumiuayHe4P9riTYeCQeSPmlQnTNzhxBTtcsiYbE=; b=jvIC0spW+ai3w8MZEF6bJyJwss
	vthfSW+MUvJilg61y2ZUYv0dj7JMoqPZKtyyxrEYl4wYB1UZw6NID6DE/QeVFbrGWCVlybtQ90jRW
	Alz+LQXCgmgG+0eWT7bUH69OwfJ8jGxkT+P4ws3O0H4weOEjKnlf+q8R1i5cAjh02iVY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0wHK-0004Lm-Sk;
	Mon, 31 Aug 2026 07:18:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1x0wHJ-0004LX-Ge
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 07:18:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5aHzT2rXprXtY91yiugmupVd9/BEmB45SOlkEfbWgHs=; b=DnC0DRze3/7OkO8zQ+nZQSyN6o
 hFsXhZb26ISNQF97SoFosP3ZifEnHVuGJO/H74gQhf1/ZrPFZYXmc760dq/XkdM/44xcWbYhhxofR
 y3/wZxtj/JYhaD/lFFVAe2JPwmvVAO2rFYg0Zvf9AEDc3GuX6dRzmDl5QvUg5Z9Yu56U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5aHzT2rXprXtY91yiugmupVd9/BEmB45SOlkEfbWgHs=; b=bkD/S2Cc0YyE+re/E7IqIhJyO8
 1DyFT8JVty3kuB3/hu5AFOwfVujFR3a1UofQx82cqcnC2lbL798NlnWvC4tGDtdTpho0xMgtpuNaD
 eOPef1EUUPI0b6P7mgViryXuKJkQayA9SSmoeztTUMMj7ahXhIO4EitAu7DKFYNVOitQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0wHI-0001xf-0J for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 07:18:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 63B47601DB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 07:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CC81F000E9;
 Mon, 31 Aug 2026 07:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788160674;
 bh=5aHzT2rXprXtY91yiugmupVd9/BEmB45SOlkEfbWgHs=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=MO1MtEvXjZE/BmWHjzqEZcED9yOPugCwJQI5PZlK0OEtgYgFlIjEEkECtnnHDItHo
 CnhWUuge88clwdLhqd34troKyA7pt83JpOjCLk1Si5anlv8mArAnXXhnsqm8s/L6jW
 OVTpQFgq8tS9MTkdEA8TGxOW0aZxT8n9DqzEViGC1DHwQ8Ep2p3Er2jsg3icEPCwzF
 nnhxmZE/5dQjJ2fLjfX63cU5VC2JTTJOFvRW3thnkg+N89VG/Ipk5C7hosV9Y+TFRD
 QYBTS4ChJBv6HpDDPuXYMR2mwSetYBIcMa5xJYGeiDCbKfF4BTSbE+N3omPIdDXBhO
 mQZI0OZ4H3dqw==
Message-ID: <ba6c3800-d89a-49dc-b6c3-bf51277b2107@kernel.org>
Date: Mon, 31 Aug 2026 15:17:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: zlang@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
In-Reply-To: <cover.1784949154.git.asj@kernel.org>
X-Headers-End: 1x0wHI-0001xf-0J
Subject: Re: [f2fs-dev] [PATCH v8 0/13] fstests: add test coverage for
 cloned filesystem ids
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
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


Zorro, Ping?

Cheers, Anand

On 25/7/26 15:38, Anand Jain wrote:
> v8:
> - _require_fs_space: double the required space (x2) to account for both source and clone
> - Use proper quoting/unquoting for _mkfs_dev (Thanks Darrick)
> - Call _fail() if cp fails
> - _require_fanotify_function: check for kernel fsnotify support
> - _require_unique_f_fsid: reorganize comments and replace 'if' with 'case' statement (Thanks Darrick)
> - Add SEMANAGE_PROG variable (Thanks Darrick)
> - fanotify verification: add checks for SEMANAGE_PROG and _require_fanotify_function
> - Verify that the monitoring process is actually created
> 
> v7:
>   https://lore.kernel.org/fstests/cover.1781694879.git.asj@kernel.org
> 
> v6:
>   https://lore.kernel.org/fstests/cover.1779939330.git.asj@kernel.org
> 
> v5:
>   https://lore.kernel.org/fstests/cover.1779367627.git.asj@kernel.org
> 
> v4:
>   https://lore.kernel.org/fstests/cover.1777357320.git.asj@kernel.org
> 
> v3:
>   https://lore.kernel.org/fstests/cover.1777281778.git.asj@kernel.org
> 
> v2:
>   https://lore.kernel.org/fstests/cover.1774090817.git.asj@kernel.org
> 
> v1:
>   https://lore.kernel.org/fstests/cover.1772095513.git.asj@kernel.org
> 
> This series adds fstests infrastructure and test cases to verify correct
> filesystem identity when a filesystem is cloned (block-level copy).
> Test covers inotify, fanotify, f_fsid, libblkid, IMA, exportfs file handles
> and libblkid tools verify with metadata_uuid.
>   New helpers:
>    _loop_image_create_clone() and _loop_image_destroy() to help create fs and clone
>    _clone_mount_option() helper to apply per-filesystem clone mount options
>    _require_fanotify_function check if kernel supports fs notification
>    _require_unique_f_fsid() helper to handle fs difference in fsid implementation
> 
>   New tests:
>   - fanotify events are isolated between cloned filesystems
>   - f_fsid is unique across cloned filesystem instances
>   - libblkid correctly resolves duplicate UUIDs to distinct devices
>     with and without metadata_uuid
>   - IMA distinct identity for each cloned filesystem
>   - exportfs file handles resolve correctly on cloned filesystems
> 
> Kernel Patches:
>   Requires Btrfs kernel patches for all tests to pass.
>    [1] https://lore.kernel.org/linux-btrfs/cover.1777281686.git.asj@kernel.org
> 
> 
> Anand Jain (13):
>   fstests: add _loop_image_create_clone() helper
>   fstests: add _clone_mount_option() helper
>   fstests: add FSNOTIFYWAIT_PROG
>   fstests: add _require_fanotify_function
>   fstests: add _require_unique_f_fsid() helper
>   fstests: add SEMANAGE_PROG
>   fstests: verify fanotify isolation on cloned filesystems
>   fstests: verify f_fsid for cloned filesystems
>   fstests: verify libblkid resolution of duplicate UUIDs
>   fstests: verify IMA isolation on cloned filesystems
>   fstests: verify exportfs file handles on cloned filesystems
>   fstests: add _change_metadata_uuid helper
>   fstests: test UUID consistency for clones with metadata_uuid
> 
>  common/config         |   2 +
>  common/rc             | 135 +++++++++++++++++++++++++++++++++++++++
>  tests/generic/801     | 143 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/801.out |   7 +++
>  tests/generic/802     |  64 +++++++++++++++++++
>  tests/generic/802.out |   4 ++
>  tests/generic/803     |  72 +++++++++++++++++++++
>  tests/generic/803.out |   6 ++
>  tests/generic/804     | 108 +++++++++++++++++++++++++++++++
>  tests/generic/804.out |  10 +++
>  tests/generic/805     |  80 +++++++++++++++++++++++
>  tests/generic/805.out |   2 +
>  tests/generic/806     |  74 ++++++++++++++++++++++
>  tests/generic/806.out |   6 ++
>  14 files changed, 713 insertions(+)
>  create mode 100644 tests/generic/801
>  create mode 100644 tests/generic/801.out
>  create mode 100644 tests/generic/802
>  create mode 100644 tests/generic/802.out
>  create mode 100644 tests/generic/803
>  create mode 100644 tests/generic/803.out
>  create mode 100644 tests/generic/804
>  create mode 100644 tests/generic/804.out
>  create mode 100644 tests/generic/805
>  create mode 100644 tests/generic/805.out
>  create mode 100644 tests/generic/806
>  create mode 100644 tests/generic/806.out
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
