Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FD6C369C2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:14:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u8JoW-0004o8-Vh;
	Fri, 25 Apr 2025 14:14:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@redhat.com>) id 1u8JoQ-0004nv-PF
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Apr 2025 14:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+56DXeTRhlNEKH15kYjYN9CkoAbVGHVIzlTJdE9juGM=; b=KVbJUB903Q7CWewmwSgHHaVeFm
 oOW2A23S+mEkx0G++4KdlGruFD/b13EpkmQqmXc5LkjbQm83X6NHRGVzlQ0SrArRRoHUxjGNwrluw
 6LD2JE7Zkpn1hXR5aohtzskS3kmUlgoYO+ktwJVjGIQu+hLsDdtPq/SP6jc7Gg2jQYhQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+56DXeTRhlNEKH15kYjYN9CkoAbVGHVIzlTJdE9juGM=; b=DE9EyhDxiYyVIZAgagi7U8FRQw
 YkpMEPWtrjMxxE3alwBAeypowx7OORh29UxXq3m7sUJULDtgAr+yXK12kUmJk1YGP/b4IiUNxl8mF
 IMmCPhS6pUP20Z1YOo39Hj6uYGSxcQDbAxDoLkSax3wHnH0cweMUdnNyC0sGMjTgAsKM=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1u8Jo9-00026e-UQ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Apr 2025 14:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745590401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+56DXeTRhlNEKH15kYjYN9CkoAbVGHVIzlTJdE9juGM=;
 b=aCyFVzI1yHmPKf0JYKSVCdCBZdCUxPY++fR4apd6ttr+X/p9GgPfE5POILmml/QuXoA+JH
 I9dIF2gnEllXvecdFmZ/iZJptke1ec2x8XUglXuMfqkvp+ZhTQygMmtB9H68WkR64NkQwS
 7tDVp78p3L4gItH8Wooz3K1wj7BsOH4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-hP74ED5xMjKgXcnag1YZVA-1; Fri, 25 Apr 2025 10:13:19 -0400
X-MC-Unique: hP74ED5xMjKgXcnag1YZVA-1
X-Mimecast-MFC-AGG-ID: hP74ED5xMjKgXcnag1YZVA_1745590397
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-af972dd0cd6so1365207a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 25 Apr 2025 07:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745590397; x=1746195197;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+56DXeTRhlNEKH15kYjYN9CkoAbVGHVIzlTJdE9juGM=;
 b=SUKqmAM/29t3LyjZe44fqcUkc+/WkpL9/+y+6o8mqjLGcZAF5J9wzE6BpmtAPWUrkL
 YFMd/0TtX8usrviTeSaxGZ9wBmFODVII8WHlmEHuh6607guGZScdB88TXGlqRXiZLi6b
 2+VCSWfz9enKGyavYAenjYiM9TQYDXOkD8Z82q2nhNM1Ss8fQXcrIjBEblLExzHl4SgK
 5oVdYjFiA8uQd11OSjNy2asXSjLCfYfMRPHDECqkO+URv05zgzbWZGx2XObsIfzYn8zX
 4wFNr+DuBVCE/5SuIFxDiNY6Sy/6C8uvTemvol+zwRMT48+qE5Xe7oyPWVz4hL6Llsqy
 /nPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhkY3PagdjIZ51vGCZvWs/ML3j/jVAeF6T1V/MQMyW/gd2AenJVnVpwxyBhxTahRGZcAWvAYtDYfa1BOyB2q0z@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzwtGH5bzvYy2eO1OvIEPbfkrio1vVYoyf7Km/h2xQSbb/XGFt8
 zgSRMouqJxF7aCSu811C/bLG3f4p4B3y+bg5mJjScsibwnvJMrJojB2pTIQ8wockOEA1EramAwy
 IuFXK9oQDnx7a6telXHjxu7O/x2iex9WjqmKwnzfmZvmEa/4PSmrxKdCAn6iD13APwCqw1jChUW
 Ey/lBxqp4=
X-Gm-Gg: ASbGncv2TeiI1I2YkPEJ8HjVaGnDPdy5dRA4YLjb/Rx1VU+85q2k6ISRX8Wqff1wz31
 OUdE3QCy6bpQaDd3/sGcKpxR1qKiwFbJP02asM1YYDsQQi4fiCEfvNr0PS73jjk+Dsk5fDOrbk4
 6ppIq/abi0fM2QGxmNHSwbvp28KQfScUGrnClVGJS7nPh9HuBdtdBwyUK8a9LmYx5KjVCXCCcQv
 KHxl+xkUgS9rvNpQbBAwhs8DvUfjwfzU+cDK0v27MCuPplKhRyTGVzuyudDpstxJTBZEd3MxDI/
 SphEGum4xrE9p4p8vPruoIdf8WHxrTL+eMV2oe7a+mqij2J6ynEM
X-Received: by 2002:a05:6a20:e18a:b0:1f5:8605:9530 with SMTP id
 adf61e73a8af0-2045b99adb4mr3830322637.28.1745590396911; 
 Fri, 25 Apr 2025 07:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgvgTGq3g0gY77ie1PKeHiig1FtrvzCFz6cgKQ+lBDFCUMDkGrIrMmrFN45D5f6+SS26z8iQ==
X-Received: by 2002:a05:6a20:e18a:b0:1f5:8605:9530 with SMTP id
 adf61e73a8af0-2045b99adb4mr3830283637.28.1745590396565; 
 Fri, 25 Apr 2025 07:13:16 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a66dsm3269847b3a.102.2025.04.25.07.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 07:13:16 -0700 (PDT)
Date: Fri, 25 Apr 2025 22:13:11 +0800
To: Chao Yu <chao@kernel.org>
Message-ID: <20250425141311.kgwsazvt6r65yfod@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250327055051.3827735-1-chao@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250327055051.3827735-1-chao@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -3IyjhajLjA1cYLDUxjZxfUSXva3VDJZhd1FHe5zqZY_1745590397
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1u8Jo9-00026e-UQ
Subject: Re: [f2fs-dev] [PATCH v2] f2fs/011: test to check out-of-space issue
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@redhat.com>
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 27, 2025 at 01:50:51PM +0800, Chao Yu wrote:
> This is a regression testcase to check whether we will handle
> out-of-space case correctly during fallocate() on pinned file
> once we disable checkpoint.
> 
> Testcase:
> 1. mount f2fs w/ checkpoint=disable option
> 2. create fragmented file data
> 3. set flag w/ pinned flag
> 4. fallocate space for pinned file, expects panic due to running
> out of space.
> 
> We should apply both commit ("f2fs: fix to avoid panic once
> fallocation fails for pinfile") and commit ("f2fs: fix to avoid
> running out of free segments") to avoid system panic.
> Note that w/ these two commit, we fixed such issue in both
> convential and zoned block device.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - clean up codes suggested by Zorro
> - change output to expect ENOSPC error if we have applied fixes

Sorry I missed this V2, this version looks good to me. As there's not
more review points from f2fs list, so I'd like to merge it:

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/011     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/011.out |  2 ++
>  2 files changed, 55 insertions(+)
>  create mode 100755 tests/f2fs/011
>  create mode 100644 tests/f2fs/011.out
> 
> diff --git a/tests/f2fs/011 b/tests/f2fs/011
> new file mode 100755
> index 00000000..ec3d39ec
> --- /dev/null
> +++ b/tests/f2fs/011
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/011
> +#
> +# This is a regression testcase to check whether we will handle
> +# out-of-space case correctly during fallocate() on pinned file
> +# once we disable checkpoint.
> +# 1. mount f2fs w/ checkpoint=disable option
> +# 2. create fragmented file data
> +# 3. set flag w/ pinned flag
> +# 4. fallocate space for pinned file, expects panic due to running
> +# out of space
> +# We should apply both commit ("f2fs: fix to avoid panic once
> +# fallocation fails for pinfile") and commit ("f2fs: fix to avoid
> +# running out of free segments") to avoid system panic.
> +# Note that w/ these two commit, we fixed such issue in both
> +# convential and zoned block device.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_fixed_by_kernel_commit 48ea8b200414 \
> +	"f2fs: fix to avoid panic once fallocation fails for pinfile"
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"f2fs: fix to avoid running out of free segments"
> +
> +_require_scratch
> +_require_command "$F2FS_IO_PROG" f2fs_io
> +
> +_scratch_mkfs_sized $((1*1024*1024*1024)) >> $seqres.full
> +_scratch_mount -o checkpoint=disable:10%
> +
> +pinfile=$SCRATCH_MNT/file
> +
> +# simulate fragment status in f2fs
> +for ((i=0;i<256;i++)) do
> +	$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/$i >>$seqres.full
> +done
> +sync
> +
> +for ((i=0;i<256;i+=2)) do
> +	rm -f $SCRATCH_MNT/$i
> +done
> +sync
> +
> +touch $pinfile
> +$F2FS_IO_PROG pinfile set $pinfile >> $seqres.full
> +$XFS_IO_PROG -c "falloc 0 $((3*256*1024*1024))" $pinfile
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/011.out b/tests/f2fs/011.out
> new file mode 100644
> index 00000000..559c3fdf
> --- /dev/null
> +++ b/tests/f2fs/011.out
> @@ -0,0 +1,2 @@
> +QA output created by 011
> +fallocate: No space left on device
> -- 
> 2.49.0
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
