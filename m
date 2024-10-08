Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27BBCED25B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Oct 2024 02:57:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sy0Pi-0000jj-No;
	Tue, 08 Oct 2024 02:57:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sy0Pi-0000ja-1l
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Oct 2024 02:57:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sy5ONQUFXVcnV4//B89y+IJAji/bL+2Ss2sWK46IQUA=; b=PQoOJlCLvtgJ7f/bnwQL/4E0/+
 5Zk1F+uwKyDTRZzAL23Oz1ZJdBmhbYGPH6nnQVf0F5cFf1ZpyHDOTbTxgwufSzfnT0taPLyx8nIZo
 rUwODYCpmeSFdBrAUa93oRAhJ6y8QxE7UDlytBvBLPvB4h+/9bmzbODCgGGGu4spgKy0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sy5ONQUFXVcnV4//B89y+IJAji/bL+2Ss2sWK46IQUA=; b=TTu6KiIKL7xT4uTgvuwaNSScBa
 4/FML2grXjH29dQh+cVxacVG89oRUqMwoR+Tr4wfu2ljP8E1nstNEfcT7QmWeqyW9hWLSpmAkmB6b
 C0qnsfj6AEnjL/PV0mveGj14jI2TPF06U9gc3UlaiAu+JNgOn1b6m3zCfZYYyeNRdODY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sy0Ph-0003Pd-DJ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Oct 2024 02:57:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C4D625C58EF;
 Tue,  8 Oct 2024 02:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F89C4CEC6;
 Tue,  8 Oct 2024 02:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728356238;
 bh=tYoizC/9cSnXCwqV2/3ziGZiBxqaimtQwdOuus2djNk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=lWRBBK3aekOSw3rSwB8/IVBqPVdRCkivOODPjnsXjj4rJLnWLrMxtlmos0NlY2hMt
 vBFs3ER2eOdceh9By5c3T0B3pRbbILRlwnQ31H8SPxX8hDSs2/n0k7ZQChnNNzsCiQ
 alLOvk/9GEsGVDRe8iwlYFLvQ4EFCs7F7Ok1pHjcgCS8CtOidSkX6HI0saAOkqDPwg
 Rst8+NLHC/ZKSH/TFRlZ0cGVHEOLaAL2x5J/D0NTAS1iQspJ1W2ES9tP2ggmHqpUlg
 LePdjzQ1NbudVf8V7JRi4ppyPJtMJ8DOVp5rd/tLfezGwe51jsTZMgRfDj8+X1FF1U
 vgiWMeDTJofqg==
Message-ID: <1f0f8f49-b220-4b5d-a141-6d8dcecb9ab2@kernel.org>
Date: Tue, 8 Oct 2024 10:57:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20240929080011.3802327-1-hanqi@vivo.com>
Content-Language: en-US
In-Reply-To: <20240929080011.3802327-1-hanqi@vivo.com>
X-Headers-End: 1sy0Ph-0003Pd-DJ
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: fix inconsistent update
 of i_blocks in release_compress_blocks and reserve_compress_blocks
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/9/29 16:00, Qi Han wrote:
> After release a file and subsequently reserve it, the FSCK flag is set
> when the file is deleted, as shown in the following backtrace:
> 
> F2FS-fs (dm-48): Inconsistent i_blocks, ino:401231, iblocks:1448, sectors:1472
> fs_rec_info_write_type+0x58/0x274
> f2fs_rec_info_write+0x1c/0x2c
> set_sbi_flag+0x74/0x98
> dec_valid_block_count+0x150/0x190
> f2fs_truncate_data_blocks_range+0x2d4/0x3cc
> f2fs_do_truncate_blocks+0x2fc/0x5f0
> f2fs_truncate_blocks+0x68/0x100
> f2fs_truncate+0x80/0x128
> f2fs_evict_inode+0x1a4/0x794
> evict+0xd4/0x280
> iput+0x238/0x284
> do_unlinkat+0x1ac/0x298
> __arm64_sys_unlinkat+0x48/0x68
> invoke_syscall+0x58/0x11c
> 
> For clusters of the following type, i_blocks are decremented by 1 and
> i_compr_blocks are incremented by 7 in release_compress_blocks, while
> updates to i_blocks and i_compr_blocks are skipped in reserve_compress_blocks.
> 
> raw node:
> D D D D D D D D
> after compress:
> C D D D D D D D
> after reserve:
> C D D D D D D D
> 
> Let's update i_blocks and i_compr_blocks properly in reserve_compress_blocks.
> 
> Fixes: eb8fbaa53374 ("f2fs: compress: fix to check unreleased compressed cluster")
> Signed-off-by: Qi Han <hanqi@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
