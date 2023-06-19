Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A86EB64D7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Jun 2023 01:32:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qB3kO-0003bJ-JS;
	Mon, 19 Jun 2023 01:32:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qB3kC-0003b7-As
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Jun 2023 01:31:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=42OmGdkNYDkY7qJc94mK2jsPbWVWGLVaDe43klbZfcY=; b=WTgh4b9V1i2ik0JnoQr/dVFett
 yFk1qySeRgXfzgCW/mScugdUweS0Fa5FrzNIR1MVl+AcjopjenZ9f/VkAYCaDcqdcjw/paUzhZ8ji
 u2V8tOr2qyXUv/hUcaNC/n9R0+Bo/e1n6i+2SrBhDKIwQtGK/BS4dDp2wrrv2cqa1oXo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=42OmGdkNYDkY7qJc94mK2jsPbWVWGLVaDe43klbZfcY=; b=V0DrtRbogMCrf278t4G0MasRPZ
 VEt0A60FB4nM9MyqOVw6Bo9UAYuP0bVgny2vUxGin6+ad5ZdJQ1UkHKpMVUAvPP5CuieYE0i7nc9w
 HKHpdLgYO/9CH7GLmL/Oe5tVfnoQNSpLkzFk9W+FGTET0CkGFZq5T7wGz5B6DkHyIWQQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qB3kC-008E1j-AC for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Jun 2023 01:31:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8338760EFC;
 Mon, 19 Jun 2023 01:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E3CC433C0;
 Mon, 19 Jun 2023 01:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687138301;
 bh=i3jkIUwYMg0GoBLvyBEiJO0i1ENUUhOWr6sshjDMEpM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kUllh/f0NoNMU2ZcAhzXYlzyRRLJO8p75zYc+jWDd41d0jEqA7eD4E1HSsQ1ffe6o
 d/h2XcGNJvwUDS7nwDY9acWTORJyxQl/RQCqSDHDQruSium5aHcgh+Bc9WXUfYXeMJ
 X9R9KE6gaqR8Ig1GIWuFfQypAPspBYx4SmGmFcf5ZEgjsEHe6R2WNi6vryxPUyxV0y
 3ya5BYXVxI+EyxEdJqiJU37otoSReF+rUJvRURUunDdxb9S5r5mCDezMC3qID1024s
 dszuuxr40JYnOGhmr8K/L9g1gQGQ8Wev4xH7FKEFsq3VjrjSQ7qcDCJRmRXARmSb/y
 Il8DlNoTeTxYg==
Message-ID: <0a6619cd-444b-69c4-818b-1b6dd6757c6c@kernel.org>
Date: Mon, 19 Jun 2023 09:31:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230506151604.36890-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230506151604.36890-1-frank.li@vivo.com>
X-Headers-End: 1qB3kC-008E1j-AC
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: refactor struct f2fs_attr macro
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
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/6 23:16, Yangtao Li wrote:
> This patch provides a large number of variants of F2FS_RW_ATTR
> and F2FS_RO_ATTR macros, reducing the number of parameters required
> to initialize the f2fs_attr structure.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304152234.wjaY3IYm-lkp@intel.com/
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
