Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA52E606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ghElfzn3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iq7lSVR+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=icWmMQHK;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GzvswWaE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=r7eqfTF3WsHnAVXZ6C4ODGWWK6YTbAqCg8IzvZiW3c4=; b=ghElfzn3fZaIDrpwiKXbzJCZUE
	iEOIlvkZW/w4EHrRnXKV4dSES2R/fx1YQ87FmGpuaECPZ5ag3ZQuOY0GfQcWDwfi2VEZLRJ9O0fUr
	ZvStkGRwMTK4SzaJ9JGrZNVXnNrm9oA0Vt8jJYD+bkykwxBWtkpVJUQWj+tKz6uyJYIQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVZ4L-000000005kv-1NOm;
	Mon, 23 Nov 2026 18:47:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVZ4B-000000005kj-4Aoj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:47:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jEgTy2gI/IlCDectbC/WzfFgVpdI3lObRhjlmOoXpHw=; b=iq7lSVR+beAzkO9ZW/n2Y4YZxk
 heAFV5slxae6YPhbi8Cdywisea72BwDTFTItPVCp1wNsL7CpnDGYlfyhXf262Njjne4qGy38+73mk
 DqefMQRkqladzKu4XjLnRVvwcrTm5GiqxLfcw6S8ppSL1iuqAbkcTZH16cON9gll/6p8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jEgTy2gI/IlCDectbC/WzfFgVpdI3lObRhjlmOoXpHw=; b=icWmMQHKGHzlnB6EkcFnho2y+M
 GrS88jdDvSE0izs2XvdZuBf6caJTfOa5WV1HSFe8pWXCj9YUwgJEvHyAKxCK4dZiAYbQcCrijUNLB
 D4gh7iroNwkpsY4svlB33t33qxH1SuC+q1GmGJQgSokIUJjEsHFMXKYTUawxG8ekFGVg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVZ4A-000000003w4-2YpE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:47:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 36CA144DBB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 18:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D621F000C4;
 Mon, 23 Nov 2026 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795459616;
 bh=jEgTy2gI/IlCDectbC/WzfFgVpdI3lObRhjlmOoXpHw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GzvswWaElhQlroSK2fjY7vkgFjL0BjMCQz9a96B9OOTuABcrMrbDQ4MbJQkoCyUb+
 XI5K/xaybbNy1Tw07I+9swqdUJJyQ2lFoK86+qNQuZmGsL2vH/Yng0+8YCXkjTS2F4
 2riLyDzHPE6CaMAoEnoWOPntBxpkC5D+zfO4j1thB54c2Xn8GE+OyD7EmUsSKWTuGr
 4KjXY8OoIdRodDXngaqAFoP4KFcfODgMPbvtN+F5JJ+fU2e4djuvYKucMdjGhS0uQ8
 BOkcdFbwhSfz6c9bZwfjrLPiEIJm/vAvnbkPT7S7w4Ov05OPRU0qS6LT0qhilUlnMM
 bItVF/PAXBpaQ==
Date: Tue, 24 Nov 2026 02:46:47 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSJ4nnsW6m7_J7H@zlang-mailbox>
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
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVZ4A-000000003w4-2YpE
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

Reviewed-by: Zorro Lang <zlang@kernel.org>

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
> +
> +_fixed_by_fs_commit btrfs 72de4807ba84 \
> +	"btrfs: derive f_fsid with dev_t only when temp_fsid is active"
> +
> +_scratch_mkfs_uuid >> $seqres.full 2>&1 || _fail "mkfs failed"
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
