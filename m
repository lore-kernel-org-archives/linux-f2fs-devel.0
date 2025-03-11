Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76E7C282EC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:07:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ts0G7-00068W-Md;
	Tue, 11 Mar 2025 14:07:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@redhat.com>) id 1ts0G5-00068K-4h
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 14:07:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0OPOZ7he65BOXlfA9oSho8t0fS/rmeaaXJ+CF5+1mAc=; b=XESsGh+16ONIg0PLL3yvy2o/Ix
 H4oH/s7mw7OP052BuA7bNuY/i3BwrsAgFJY/WCyAELjjLztR5vDfmB57TDfXlwrEr/ipJRQF1WZ2a
 M5MlVPT3oJywC9gJVt7+L+5/MYDLwXf8hNqmpneALZb0SmUO7IaGjQGnY8Z3gUlDAk6A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0OPOZ7he65BOXlfA9oSho8t0fS/rmeaaXJ+CF5+1mAc=; b=LHdYh2ECIi2/aTBxkWxlwk4ngW
 FzsG3/HVr0yIGMnKuawmGv9PC0uU2g2RjCez4mIQK+VdAL/v/B9ZqoqjRUHjbgj0NVg2Sm/pWvMDO
 I/9xtJK+wl81g7CUyjsfpp7t19rxTVudZ3S70JiQH5cJ/ivM8kf/BHgnFlgMOjZWkXEs=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ts0Fu-000511-9E for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 14:07:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741701999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0OPOZ7he65BOXlfA9oSho8t0fS/rmeaaXJ+CF5+1mAc=;
 b=Q1t7WK3IfZK+gZhy8Jbht0bVd8giwzahKB2q/RA9VX/Zlmu46rDhxpQVb7OzW1elkJlaje
 +AhkwPGZaEI+HTZcPFGpVT7A+aURsSIRNy/Z5JHfKdMsKXjPGOkaVyQxbKds7dAnY1rRAS
 jkguOkCvFAtVc0xAUaZyHWHBBxPcQx4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-Xz2R11YwOf-zpknAyM92gA-1; Tue, 11 Mar 2025 10:06:36 -0400
X-MC-Unique: Xz2R11YwOf-zpknAyM92gA-1
X-Mimecast-MFC-AGG-ID: Xz2R11YwOf-zpknAyM92gA_1741701995
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff53a4754aso15314375a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Mar 2025 07:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741701995; x=1742306795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OPOZ7he65BOXlfA9oSho8t0fS/rmeaaXJ+CF5+1mAc=;
 b=dGJyS/qhbU8Z998t8fWFaf7LNmfIlcXaT5qcHJYg0rQQztSEZmE7E5Vjxcl9cAQDDs
 a1I9GSUhrRALxWVGh3zDvz7btPnKkL4pekISwTuxAxcGSCzhlaE10aBqiTPX+K7crB+0
 LKuhN3u3kqq7XBu4fg0aW18/+uiPWS+s0MpB1EPyZKq9NX83z23ArszMAL0MiMjSmIlx
 lwNBodHKH4ic+Yw+RewX7RrWYLHMCmIDFUpEBaTnFCk2BJrxaAsC6YIiyQiVmyfG9Br8
 iANHoHwEzYVIE20w9P5ygrW4X2gk2V8u2ia3z1UvofqCtKCIEyZDGl9Fba5Gnd+mxjRa
 NiFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq+NHnBVsz/hus2Gfoi2cAFIxPAdpJd2Ps8y1rM6ANwrNy9m8y2joEGwhk2ty1W5WV4A4X9uXXdlf5bpWN5VDf@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzxh6C1jy6BZHE3N3NSoa++kUI614r63dlDouzNeBtaBNi6rN7t
 EW4K9L8QvxhYp9SRAbLf7t4r9DK2LAiHduJ03cykAPwmHZwoyRHWJU1+fOXa+IzPuIHbOmQ7rBL
 TzWWApvw0IuUnRW12w9+xJcY+/4CAwQwKPeLcyOwSK7eRLQfPAm6zmJ8u0t1mleq4GuAM/Yffku
 Bd+yOJFST0qw==
X-Gm-Gg: ASbGncsQmHKTLyBwmFefIgoWdE2dJyiEqtyWq1QCYqNAveEuIZynOrscrj8Y6j9l9tS
 pb8ibkUUO0vS+XyAz5lMwaLMd8KgeMuDT7j/BANlftRBI2IkR34EZhZtt+KESiBvR3NgO2QQPO/
 uXjKfSIoFP5f95ZAlA1c0UhidQZqrbDHFVVfmROYuEVdhK/ZX4bW7maEQjwElZwkkOq8iY/1M8H
 Z7DfnSuBffzoq4c9GnCZ0oEU1s+/ra9hoLWgzCD5O/98sneRfjxE9Gybf+V10cigXa4SdZ6bLxR
 p5bIrl22sLXLMX/vILMScdFUFCkUQBMJEsuaUkQ/9uLuZEOPDgLN0zNj
X-Received: by 2002:a05:6a20:160c:b0:1f5:8c86:5e2f with SMTP id
 adf61e73a8af0-1f58c8660a5mr7186312637.37.1741701994901; 
 Tue, 11 Mar 2025 07:06:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOUM0EgF5JQvrEivKy6KbPfAQKra7zwYiLgOcmGGJhXJkcLBoKcLzljd22x+SxHMoK67xzLg==
X-Received: by 2002:a05:6a20:160c:b0:1f5:8c86:5e2f with SMTP id
 adf61e73a8af0-1f58c8660a5mr7186270637.37.1741701994572; 
 Tue, 11 Mar 2025 07:06:34 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b322e537sm8111916b3a.38.2025.03.11.07.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 07:06:34 -0700 (PDT)
Date: Tue, 11 Mar 2025 22:06:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Message-ID: <20250311140629.acdx54w4t3pitl22@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250311080430.3696582-1-chao@kernel.org>
 <20250311080430.3696582-6-chao@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250311080430.3696582-6-chao@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fP6szYkklif_OXuIfHq81VAKw0yw2QlF7H4qhTuJQdk_1741701995
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1ts0Fu-000511-9E
Subject: Re: [f2fs-dev] [PATCH v3 6/6] f2fs/009: detect and repair nlink
 corruption
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
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Mar 11, 2025 at 04:04:30PM +0800, Chao Yu wrote:
> This is a regression test to check whether fsck can handle corrupted
> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> and expects fsck.f2fs can detect such corruption and do the repair.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - check socket command
> - add _cleanup to kill & wait background thread
> - add commit title in _fixed_by_git_commit line
> - clean up codes
>  tests/f2fs/009     | 145 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/009.out |   2 +
>  2 files changed, 147 insertions(+)
>  create mode 100755 tests/f2fs/009
>  create mode 100644 tests/f2fs/009.out
> 
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> new file mode 100755
> index 00000000..4f8b2079
> --- /dev/null
> +++ b/tests/f2fs/009
> @@ -0,0 +1,145 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/009
> +#
> +# This is a regression test to check whether fsck can handle corrupted
> +# nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> +# and expects fsck.f2fs can detect such corruption and do the repair.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +if [ ! -x "$(type -P socket)" ]; then
> +	_notrun "Couldn't find socket"
> +fi
> +
> +_require_scratch
> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_command "$F2FS_FSCK_PROG" fsck.f2fs
> +
> +_fixed_by_git_commit f2fs-tools 958cd6e "fsck.f2fs: support to repair corrupted i_links"

_fixed_by_git_commit f2fs-tools 958cd6e \
	"fsck.f2fs: support to repair corrupted i_links"

> +
> +filename=$SCRATCH_MNT/foo
> +hardlink=$SCRATCH_MNT/bar
> +
> +_cleanup()
> +{
> +	if [ -n "$pid" ]; then
> +		kill $pid &> /dev/null
> +		wait
> +	fi

	cd /
	rm -r -f $tmp.*

I don't have more review points on this test case now, f2fs list might give it
more reviewing :)

Thanks,
Zorro

> +}
> +
> +for ((i=0;i<14;i++)) do
> +	echo "round: " $i >> $seqres.full
> +
> +	_scratch_mkfs >> $seqres.full
> +	_scratch_mount
> +
> +	if [ $i == 0 ]; then
> +		touch $filename
> +		ino=`stat -c '%i' $filename`
> +		nlink=0
> +	elif [ $i == 1 ]; then
> +		mkdir $filename
> +		ino=`stat -c '%i' $filename`
> +		nlink=1
> +	elif [ $i == 2 ]; then
> +		mknod $filename c 9 0
> +		ino=`stat -c '%i' $filename`
> +		nlink=0
> +	elif [ $i == 3 ]; then
> +		mknod $filename b 8 0
> +		ino=`stat -c '%i' $filename`
> +		nlink=0
> +	elif [ $i == 4 ]; then
> +		mkfifo $filename
> +		ino=`stat -c '%i' $filename`
> +		nlink=0
> +	elif [ $i == 5 ]; then
> +		socket -s $filename >> $seqres.full 2>&1 &
> +		pid=$!
> +		sleep 2
> +		ino=`stat -c '%i' $filename`
> +		kill $pid >> $seqres.full 2>&1
> +		nlink=0
> +	elif [ $i == 6 ]; then
> +		ln -s $SCRATCH_MNT/empty $filename
> +		ino=`stat -c '%i' $filename`
> +		nlink=0
> +	elif [ $i == 7 ]; then
> +		# orphan inode
> +		touch $filename
> +		ino=`stat -c '%i' $filename`
> +		$F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
> +		stat $filename >> $seqres.full
> +		rm $filename
> +		$F2FS_IO_PROG shutdown 1 $SCRATCH_MNT/ >> $seqres.full
> +		sleep 6
> +		nlink=1
> +	elif [ $i == 8 ]; then
> +		# hardlink on file
> +		touch $filename
> +		ino=`stat -c '%i' $filename`
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 9 ]; then
> +		# hardlink on charactor
> +		mknod $filename c 9 0
> +		ino=`stat -c '%i' $filename`
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 10 ]; then
> +		# hardlink on blockdev
> +		mknod $filename b 8 0
> +		ino=`stat -c '%i' $filename`
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 11 ]; then
> +		# hardlink on pipe
> +		mkfifo $filename
> +		ino=`stat -c '%i' $filename`
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 12 ]; then
> +		# hardlink on socket
> +		socket -s $filename >> $seqres.full 2>&1 &
> +		pid=$!
> +		sleep 2
> +		ino=`stat -c '%i' $filename`
> +		kill $pid >> $seqres.full 2>&1
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 13 ]; then
> +		# hardlink on symlink
> +		ln -s $SCRATCH_MNT/empty $filename
> +		ino=`stat -c '%i' $filename`
> +		ln $filename $hardlink
> +		nlink=0
> +	fi
> +
> +	if [ $i != 7 ]; then
> +		stat $SCRATCH_MNT/* >> $seqres.full
> +	fi
> +	echo "ino:"$ino >> $seqres.full
> +	echo "nlink:"$nlink >> $seqres.full
> +
> +	_scratch_unmount
> +
> +	$F2FS_INJECT_PROG --node --mb i_links --nid $ino --val $nlink $SCRATCH_DEV \
> +		>> $seqres.full || _fail "fail to inject"
> +
> +	_check_scratch_fs >> $seqres.full 2>&1 && _fail "can't find corruption"
> +	_repair_scratch_fs >> $seqres.full
> +	_check_scratch_fs >> $seqres.full 2>&1 || _fail "fsck can't fix corruption"
> +
> +	_scratch_mount
> +	_scratch_unmount
> +done
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/009.out b/tests/f2fs/009.out
> new file mode 100644
> index 00000000..7e977155
> --- /dev/null
> +++ b/tests/f2fs/009.out
> @@ -0,0 +1,2 @@
> +QA output created by 009
> +Silence is golden
> -- 
> 2.48.1
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
