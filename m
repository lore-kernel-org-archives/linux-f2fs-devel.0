Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14069C19F2A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Aug 2022 13:33:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oJayN-0006Mp-7y; Thu, 04 Aug 2022 13:33:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oJayM-0006Mc-3D
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Aug 2022 13:33:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iLWpHNp6Y76dI+gIHjoMv3w3iLBayarf6rvDxDdwUyM=; b=b3T95nls3Gvmc5R5/WOWZLEBLu
 6mv30KaiuJsVIMlFdfWzqNMDkI+P8r4Z0rH0mSJIQKu9wFDwYOPtHqBRhOm6whgCNkvHpktCUG27Y
 cg1+vLpVZKUx4yPijk8bLsfm0PiSoPXuEuRgs2nscjNYZFYkgJnRx3YinjuyQxModD20=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iLWpHNp6Y76dI+gIHjoMv3w3iLBayarf6rvDxDdwUyM=; b=RIf6k1EaxSiFz/jNauhWgRjyd7
 xIsg6++SBtPUNbOrtykdCh4jnZlLcbftIH1q0PS4M2nCgKHSYe24+9tw0r2sRnqGDic+B8MXeOiVu
 GTxr5Sz/6a60cBKWpLkqn3VJyCmTEyCQHp88+pffCWPN95BN/xAGOrfZZ0JtVXEq8WxA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oJayK-00079b-Md
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Aug 2022 13:33:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB9561830;
 Thu,  4 Aug 2022 13:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40F2C433C1;
 Thu,  4 Aug 2022 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659619977;
 bh=g/dIz72q+86Kq19mtA0p0jyDcY2NYbdmwK4p46ft55g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WnvIBQRNNNYBHQ4S+rWuZS332pK2Rbxm3uhxnuRphpQRf+K14csh+TIHOHw+Wu5lQ
 SygCoe4hz0OTa2E58rIcqxYKj6sQoJMwvXdZOdwenuwpTiXl/pU4V+R4SLeZjLSodc
 4/rYEDTg4GeRKwZbUnG5q+EDYd4Ca16BV5b8WqSf6DscdWf7V2ogvUCoQxUqEVar5+
 x+XcGh0R/Njdq/hSyAiCwneMNdPzNqHtEG1Egyogby8w1xSV0m6Kjfgwsk05frPDlG
 TxBcRqyfxkjxaEgMrgT87J9C4cxak6bsjbzCf9V8YdwQ2QKgPj8dVpyFxoaK73YY+e
 47cu1vOozCi+w==
Message-ID: <7d430cc7-5f6c-536b-0e10-687c2804afa8@kernel.org>
Date: Thu, 4 Aug 2022 21:32:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Jaewook Kim <jw5454.kim@samsung.com>, jaegeuk@kernel.org
References: <25e501d8a6eb$84cf4090$8e6dc1b0$@samsung.com>
 <CGME20220803085402epcas1p2a1a70630592fa73f3404ba120c6c1ac8@epcas1p2.samsung.com>
 <20220803085358.3963-1-jw5454.kim@samsung.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220803085358.3963-1-jw5454.kim@samsung.com>
X-Headers-End: 1oJayK-00079b-Md
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: do not allow to decompress files
 have FI_COMPRESS_RELEASED
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
Cc: sj1557.seo@samsung.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/8/3 16:53, Jaewook Kim wrote:
> If a file has FI_COMPRESS_RELEASED, all writes for it should not be
> allowed. However, as of now, in case of compress_mode=user, writes
> triggered by IOCTLs like F2FS_IOC_DE/COMPRESS_FILE are allowed unexpectly,
> which could crash that file.
> To fix it, let's do not allow F2FS_IOC_DE/COMPRESS_IOCTL if a file already
> has FI_COMPRESS_RELEASED flag.
> 
> This is the reproduction process:
> 1.  $ touch ./file
> 2.  $ chattr +c ./file
> 3.  $ dd if=/dev/random of=./file bs=4096 count=30 conv=notrunc
> 4.  $ dd if=/dev/zero of=./file bs=4096 count=34 seek=30 conv=notrunc
> 5.  $ sync
> 6.  $ do_compress ./file      ; call F2FS_IOC_COMPRESS_FILE
> 7.  $ get_compr_blocks ./file ; call F2FS_IOC_GET_COMPRESS_BLOCKS
> 8.  $ release ./file          ; call F2FS_IOC_RELEASE_COMPRESS_BLOCKS
> 9.  $ do_compress ./file      ; call F2FS_IOC_COMPRESS_FILE again
> 10. $ get_compr_blocks ./file ; call F2FS_IOC_GET_COMPRESS_BLOCKS again
> 
> This reproduction process is tested in 128kb cluster size.
> You can find compr_blocks has a negative value.
> 
> Fixes: 5fdb322ff2c2b ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
> 
> Signed-off-by: Junbeom Yeom <junbeom.yeom@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Jaewook Kim <jw5454.kim@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
