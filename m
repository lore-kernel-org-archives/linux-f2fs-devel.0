Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33AFC36002
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:07:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1twslF-000160-SM;
	Tue, 25 Mar 2025 01:07:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@redhat.com>) id 1twslE-00015n-HG
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Mar 2025 01:07:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ca6tvFaMuFWGnHVvQslx3xHF4LqShHWEylSbrbBNjpo=; b=HaUTioU5UegrJsuLfsVjp/whXI
 k0yc3wnVxvHzT6dTYpma45UoUJehRO30TXidU4m7+vo8j17a73UU1Px0Ol0XkGpgKNu9H9MkyPgaW
 ERVgm3I/VR1XJNetxfdy9IWIWaIGiIHdtxH/MJwp7jW6+ANCJtvCcHDIt4AGWtBPE+KQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ca6tvFaMuFWGnHVvQslx3xHF4LqShHWEylSbrbBNjpo=; b=d54GQzmQxRjOBUq6rrlPKkmFof
 sz6ugIGUMRt8mVMJ/zdOmAHoAROfi/6h2pJF6JaQJ59yDRFtQRVCIg4I4ZMOhI/cV2bPH0zybYZ/A
 Up3BBv++8UjqfMkBMgWWWUa57s8VblIQGTtC34WFDJuSvXzbiUAFvv1CEEN3AM7qi1tA=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1twsl8-0000KA-Jn for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Mar 2025 01:07:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742864828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ca6tvFaMuFWGnHVvQslx3xHF4LqShHWEylSbrbBNjpo=;
 b=YhW6hozybPOe2o66MXLiA4g5uZInErSknVIzYjbhSvwRU8LdrhyB0XvHQx5qrakS6p8e5o
 DHZd7oEHbMP6PIVhzYRrVahcJR5YOR9w4XyLOUxN672elkUaQ/abdrarRDZ1J7i5pPdJYJ
 wM/Dhgssj6mA7Cthk9POgNJd63K2b1o=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-D1CzRjUzNBuR3nqfr3UwyA-1; Mon, 24 Mar 2025 21:07:06 -0400
X-MC-Unique: D1CzRjUzNBuR3nqfr3UwyA-1
X-Mimecast-MFC-AGG-ID: D1CzRjUzNBuR3nqfr3UwyA_1742864826
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22410b910b0so63950375ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Mar 2025 18:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742864826; x=1743469626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ca6tvFaMuFWGnHVvQslx3xHF4LqShHWEylSbrbBNjpo=;
 b=klv100pzjgL9tXe2FdLWppu8RZd+lfSoHHNIJ8JAJoi3S+UimfobSAC0gkW01hxMCa
 HZkmEsFM9zx6yIEXyiRe78fv9jUCNWLVuFlArwXMvYe5PrV3NmgKCqNa5Jpr9mpKsQiT
 NSC8aJ88Lcgk021vMp7S3nVO2T8fLQxQaXV+NVtdD/sy8Unvj6ofPlJy5ZixHhNboEvJ
 goeUb/8o2WpgN/xF3osPqQIfyqDvdixkPtS3a9npbBOjZNfzJni3/60/CRCEDzQ7L0mj
 1KW4hJHqYO/isqy4S1BC4DfsH7K8RoNqCtppmsGRpbqyeP48gDC7lkCzoiuCP98nhjfh
 urcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWXCz4JkV0gMl8w49hZZxeg38lm5y8bHA+ndXwiq7wz9y4keYn0+UTr8U1fmNSmmW1brb7HTPq9b/bIN4Arhel@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxbX3TgorpvIVnlM3OTj9hnGQBxC1LMVe0okSvRyZUXwnOBvmOR
 F2FPX54rDZLLf5zIEseK0JfjHZopGxsAO0JLROWSNH0TvCo1S226nSB1tMOQ4FoznejR9jjQXRS
 /4yQWsBeRmI+k6ha15uuADojSqJPrge1ySMCvfs0gaw0SPe6a3NNrDpf3GuA+QS64mBPGV0fSDw
 M=
X-Gm-Gg: ASbGncun7oSQkgu8dZFeJn9Z4I47URZK/JecZkOhKS/1cowEvXh8wI2DXLMIcwhxb/e
 ckd8RiYWZNAZfBfkgW2lA1cqsmLgkcYnqrIh+FKtGoDvr/hJvzVl1gyo2bROsY1jwzc/26JCyg7
 zvZcLMQ/5t3j2jL0yawgiLwWcV39SUuklJ+D3D3RsuqmYiAgiPodePTu0Wu4TnfycdcLWxGbSLo
 8C4v2PwaYRL/a37hA9tsus5vS8BCvu7Pmh/OGgXd+pGLQzRbRdpHH1jhQLiHkr32bDsC9BSZ7Ct
 sMGs5sBqyp4xqGuQKdMyvKVKnP/q5P2fyPZmXHdAu3fLMIDOBwsJB8IW
X-Received: by 2002:a17:902:ce01:b0:223:faf5:c82 with SMTP id
 d9443c01a7336-22780c7e05fmr198384905ad.8.1742864825673; 
 Mon, 24 Mar 2025 18:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3hRhwT80J0wl1cy+2s5UnRQlGubHQzmqd3tsaRVrCRoluLAqgLLpBnorMQkQc7zCzTbTfbg==
X-Received: by 2002:a17:902:ce01:b0:223:faf5:c82 with SMTP id
 d9443c01a7336-22780c7e05fmr198384655ad.8.1742864825167; 
 Mon, 24 Mar 2025 18:07:05 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da9dbsm77893365ad.179.2025.03.24.18.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 18:07:04 -0700 (PDT)
Date: Tue, 25 Mar 2025 09:07:01 +0800
To: Chao Yu <chao@kernel.org>
Message-ID: <20250325010701.pe3u2qryvjwl6dpf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250312072309.3989074-1-chao@kernel.org>
 <20250312072309.3989074-6-chao@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250312072309.3989074-6-chao@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PF5DJciClrDL9EMPjR9yMnQw_CKvbnDLlOIrRdIEsmo_1742864826
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1twsl8-0000KA-Jn
Subject: Re: [f2fs-dev] [PATCH v4 6/6] f2fs/009: detect and repair nlink
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@redhat.com>
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 12, 2025 at 03:23:09PM +0800, Chao Yu wrote:
> This is a regression test to check whether fsck can handle corrupted
> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> and expects fsck.f2fs can detect such corruption and do the repair.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v4:
> - remove unnecessary "_require_command fsck.f2fs"
> - clean up _fixed_by_git_commit line
> - fix to clean all tmp files in _cleanup
>  tests/f2fs/009     | 147 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/009.out |   2 +
>  2 files changed, 149 insertions(+)
>  create mode 100755 tests/f2fs/009
>  create mode 100644 tests/f2fs/009.out
> 
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> new file mode 100755
> index 00000000..9120d8a5
> --- /dev/null
> +++ b/tests/f2fs/009
> @@ -0,0 +1,147 @@
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

Hi Chao,

Which package provides this "socket" command? I tried to search it in Fedora, but
got nothing:

  # yum search */socket
  Updating and loading repositories:
   Fedora - Rawhide - Developmental packages for the next Fedora release                                              100% |  19.1 KiB/s |  23.6 KiB |  00m01s
   Fedora - Rawhide - Developmental packages for the next Fedora release                                              100% | 694.7 KiB/s |   6.9 MiB |  00m10s
  Repositories loaded.
  No matches found.

If it's a program by yourself, we might can put it in xfstests/src/socket.c?

Thanks,
Zorro

> +	_notrun "Couldn't find socket"
> +fi
> +
> +_require_scratch
> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +
> +_fixed_by_git_commit f2fs-tools 958cd6e \
> +	"fsck.f2fs: support to repair corrupted i_links"
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
> +	cd /
> +	rm -r -f $tmp.*
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
