Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94020C3064D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Jul 2024 03:41:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sOUOQ-0006EY-S5;
	Tue, 02 Jul 2024 03:41:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sOUOP-0006ES-5c
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Jul 2024 03:41:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KKKJ1b5fe4Jis+01upRNfzqieHZRSPQ7AXRtqGl+Rrg=; b=VFTiVLfLRXOZcIWPbiqi4sOdcH
 a8rRfyZbsd66ndnCG+KJSDGasMtS4lwLUQoyiHRZf/b4Jq/dBc/f9yPw1LlNbOna79QKFGVWT4B0N
 /0R9TFnu2N/4RyAq4HFFwmBVIYg7eH/UXEBxFfeWTt2mT3+POG3MumTPn0KugIV7F8s0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KKKJ1b5fe4Jis+01upRNfzqieHZRSPQ7AXRtqGl+Rrg=; b=XXFPUJR17+oeMjx9dhh7FILU/7
 IXQelVyYKrjXNhT/KTAUfk5kx2TNFOcJF7t6RofAC9zJeVVSYyIk/H4B8q+gjqe2sGsRl6XhQOiqb
 Gf6Ps1mZITdYu+fNg86eegZ9+FiHjGCA4WVg6YaPnjgjoxffN+4sBJKwhJb8u3+ImrMw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sOUOO-000225-O3 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Jul 2024 03:41:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9BBDE61785;
 Tue,  2 Jul 2024 03:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCF1C116B1;
 Tue,  2 Jul 2024 03:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719891674;
 bh=VjMcC6BrOd+92XpR1ahVXnv2T9GsEj/YPjLuwO9OKBA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lqko51j8hvnvqX4GAgViN3XkpJuImqqZG0NEDqidLJldsTSco+zGM4w4i4Y4+u4QE
 0VQDy2g7n+GCdwTGxA5Vuka+qCDzOhZ8UJRvIm/f5ooC8a5fHpK4/rKsYPreXH6v5J
 kygWKafmJu+lIKGUOwiBnZFxntW4/JZo/ocqD3Xao4HakKdly/KflN0HdJBSQzuN/b
 ZzfmxcZjl+qxvtUFJi3nf3HZ6QRUQF1ZMU8qCf6QQgAosPXKVRffa9aD8h6ahkAlSV
 CSQxcikObH1dRhnzYy2x59T0cPl+uVzSVvtwLjtrorksBlOwa0NlY/c0Y6CzqNtZgL
 FwFoa1KbxZfKg==
Message-ID: <02d1f7b7-ee46-4f0f-81d7-c2460f14d32d@kernel.org>
Date: Tue, 2 Jul 2024 11:41:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20240628013140.2444209-1-shengyong@oppo.com>
 <20240628013140.2444209-5-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240628013140.2444209-5-shengyong@oppo.com>
X-Headers-End: 1sOUOO-000225-O3
Subject: Re: [f2fs-dev] [RFC PATCH v2 04/10] inject.f2fs: add cp injection
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/6/28 9:31, Sheng Yong wrote:
> This patch enables injecting checkpoint. To archive this, a helper
> write_raw_cp_blocks() is added to write the first and last blocks
> of a specific cp. And print_ckpt_info() is exported to show new
> checkpoint info.
> 
> The meanings of options are:
>   * cp: means cp is injected, its argument chooses which cp pack to be
>         injected, where 0 means the current valid cp is choosen
>         automatically.
> 
> The members could be injected in cp contains:
>   * checkpoint_ver: checkpoint version
>   * ckpt_flags: checkpoint flags
>   * cur_node_segno: cur_node_segno array
>   * cur_node_blkoff: cur_node_blkoff array
>   * cur_data_segno: cur_data_segno array
>   * cur_data_blkoff: cur_data_blkoff array
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
