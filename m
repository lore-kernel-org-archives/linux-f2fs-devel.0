Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853A7EDEBF9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+v1SdsTz05mkf4APY8CfoqVErgBaAOM9cdQAF50RVqM=; b=RbIuL5zGfId35N9oxCxZcWKWf6
	J6ocUv7TyQtVF9N54eJDTV0qS0wU+0Tw9VHx68WAkRejg/ljs2vXUOCO6XYyeAYsBDY+Ub2w+KopN
	iCiqSTMgGBAmRzlHoqR5PhnobrH8HeKYAu9T+9UFotX/GTdJJMM/ZLX4Ro/+I5cwo1Ic=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxYKr-0001Lc-1Q;
	Tue, 03 Mar 2026 22:35:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vxYKm-0001LS-VA
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Mar 2026 22:35:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vmpOvLq8HlNx4MG/wusmnV6v6blY3bv8HzpA5qbtnf4=; b=Kkqis6RCZbOHX/tCcI71CPhMbd
 zNjeCf7IZ8SfFQRIQ1/jKwcBC3debZveT8yK/5jlv4G8/HGbxJfs+ZOkKM9sXeyt1CXOAvCTTV/h9
 NFKxIMhLDLcfGQyzDDbOFM3b5QS/7Z2BiVUgQVcIcPxoOSPHIMfFnkSZc2FnUBgBdW2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vmpOvLq8HlNx4MG/wusmnV6v6blY3bv8HzpA5qbtnf4=; b=KFpHdzZa8wOefMw07x/i7bdpp6
 XrjmpPuwQRNAlFeVMmxv4lGfcSf5dilAflk9RLiJ1emEp/kFzRnmlrn9tPeEJeR8ZhbjPHFGuXUFr
 CQS9jNm5febBYFc8Wzx3bdtDlyeA2xwStT7fmAhVHvdcFZwguRx/nw1Ywu2SVSzvCx/g=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxYKm-0005Lp-Il for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Mar 2026 22:35:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 36A5B407D7;
 Tue,  3 Mar 2026 22:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC8BC116C6;
 Tue,  3 Mar 2026 22:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772577310;
 bh=hLW2gogLkMlcBSOVfuRQe+4qJ4OCx+t0Wq24NyTkByk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fAUR2HdNV2dYGUW1Gp2H6pGWUeqFYY3HraLaasw6Ye5WeMS7pBk7RiASmFOVI+kYo
 LQ146BxJ57YBeCfZnPIq4HjCq/pLTAc+LsVeQneCmVcKzn1wNxkyArwOF4/8g1zWsN
 MGcDEDIxWOJB3sbw5hJld1pIeDsdTH+Gja44neawvGUsHTdat0f1k3G8KQ5AeFcw0m
 MGiZQb7RBm8GvrhX5HTW7onWMmYmLy7ZKK30ycsd3jfLNN4tS8BmkCG3Exf3VvZewo
 dKn+DJXgfIqrK/VFFAGMvf5JI3rsGjE6kB8AjEatFX7qlIl34T3HH4nSZIKHMKs88l
 dyhe1JTbMJy/Q==
Date: Tue, 3 Mar 2026 14:35:07 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260303223507.GA56397@quark>
References: <20260302141922.370070-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260302141922.370070-1-hch@lst.de>
X-Headers-End: 1vxYKm-0005Lp-Il
Subject: Re: [f2fs-dev] fscrypt API cleanups v3
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Mar 02, 2026 at 06:18:05AM -0800, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up various fscrypt APIs to pass logical offsets in
> and lengths in bytes, and on-disk sectors as 512-byte sector units,
> like most of the VFS and block code.
> 
> Changes since v2:
>  - use the local bio variable in io_submit_init_bio
>  - use folio instead of io_folio (and actually test the noinline mode,
>    which should have cought this for the last round)
>  - add an extra IS_ENABLED(CONFIG_FS_ENCRYPTION) to safeguard
>    against potentially stupid compilers
>  - document the byte length needs to be a multiple of the block
>    size
>  - case to u64 when passing the byte length
>  - move a hunk to an earlier patch
> Changes since v1:
>  - remove all buffer_head helpers, and do that before the API cleanups
>    to simplify the series
>  - fix a bisection hazard
>  - spelling fixes in the commit logs
>  - use "file position" to describe the byte offset into an inode
>  - add another small ext4 cleanup at the end

This looks good now.  I'll plan to apply this to fscrypt.git#for-next in
a bit.  Other reviews and acks appreciated.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
