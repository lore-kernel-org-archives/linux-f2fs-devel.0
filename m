Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1FEC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 01:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FHDVQ/hZp6lf4/VbV4suXl1RBPmgZs2iU1VoWBZJKrg=; b=Iit4g37FDkQGIwFjuExcWTIyJ6
	JNDXNneaqn/p8LLnY/U/ABG1oRDxja1FfkOjOyrzWzLTQjlnxb2dc8yac61naNTwNyJT30KxeOY13
	JaGgMBLUvYeLPpjpnhd6jqajd+Iwvr34sYtONJC14VG0qfEaa1BdW06v4UgfhqYowlcc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2J3G-00066r-5w;
	Fri, 04 Sep 2026 01:49:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2J3E-00066l-9X
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 01:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rgJ9Mhwkc8zl6eBcQIIymxRLlyvZddHHSbz7YMxQhis=; b=KbGAGF0U/Ni1FPhyz3epOzOyG7
 LOGg/bAEVeosQ0sbtU8gQiSsyL4vMbQL2L9OLvYitF4gT1xXJdrel0xtiGi9fseQKzgt1nQ/QYkHh
 wxm2+7dGr1ObaW8aIBiQtlrF1X2ffmJNwPwg/p7qhrXcUPgEq5MVbTeausNLNObZ+dgk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rgJ9Mhwkc8zl6eBcQIIymxRLlyvZddHHSbz7YMxQhis=; b=NXV99hVs4f21i9Q5wGYXOmh2hX
 Mi087nmtKW7xqH6+KmZ+xnyTqDY9RoijhXp6NO3kkWXbFpuSxNru5rIrj/lbG1dck+Ra5tMHnfZWx
 yJU9hanLIx5+MGaKHu/Q3rqNCilqPD80AWt/eRYRvtTVeLPM+96UocC/5SZpU7V5rkBE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2J3D-0004yr-SH for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 01:49:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D44D409CA;
 Fri,  4 Sep 2026 01:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172421F000E9;
 Fri,  4 Sep 2026 01:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788486542;
 bh=rgJ9Mhwkc8zl6eBcQIIymxRLlyvZddHHSbz7YMxQhis=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=eO8VG3/Jhp/mQmGtP7LStTAh8ZxBluGkcF4cNzPipNOLYsABNoGxvb1S472ulTfFB
 L960514KpiBam6MuBG783hPV6O90xBHsotMlzWcZ3lY79biFKdt3Y4ax1BcfczNs/i
 ncIDdp2h/lzisH42fWXP5FsUa1XNYiUquIMnKsn0y5vYMY0hzrnJfzabNdFxKFNZGa
 im4rJaQT99vH9WAXz2UxesepPR9VLfpOfB475Ugmv3Qan4n0meJ99HVhsQtlFWIA0h
 I5VdOZWfLFaj7Bk8JD6fMIbo+WWzoO/iRvoJq9HGtzpVbQWJNlbtmsjGIw+tFIgmk0
 BJAISplu4zMqQ==
Message-ID: <eae9790d-8a48-4421-94d6-1f24469e325e@kernel.org>
Date: Fri, 4 Sep 2026 09:48:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788479509.git.zhangxp1998@gmail.com>
 <41898b6a3cc76d464d6d1d8774daae6c185e88b3.1788479509.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <41898b6a3cc76d464d6d1d8774daae6c185e88b3.1788479509.git.zhangxp1998@gmail.com>
X-Headers-End: 1x2J3D-0004yr-SH
Subject: Re: [f2fs-dev] [PATCH v9 01/11] f2fs: initialize sb_info early in
 f2fs_fill_super
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/4/26 07:54, Kelvin Zhang wrote:
> Previously, init_sb_info() was invoked late in f2fs_fill_super(), after
> processing superblock error tracking, mount options, and sb->s_maxbytes.
> 
> However, read_raw_super_block() reads the superblock folio directly
> from the block device mapping using folio page offsets. This makes the
> initial static sb_set_blocksize(sb, F2FS_BLKSIZE) call redundant.
> 
> Move init_sb_info() to execute immediately after sbi->raw_super is
> attached, allowing the block device block size to be set dynamically via
> sb_set_blocksize(sb, sbi->blocksize).
> 
> This early initialization also prepares for upcoming patches that add
> dynamically computed filesystem geometry fields, such as
> sbi->addrs_per_block and sbi->nids_per_block, to init_sb_info(). These
> fields are required by earlier initialization steps, including mount option
> consistency checks and sb->s_maxbytes computation.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
