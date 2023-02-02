Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913F8C61DA4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Feb 2023 07:48:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pNUKc-0005tB-Sp;
	Thu, 02 Feb 2023 07:48:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pNUKb-0005t5-4X
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Feb 2023 07:48:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E1Ar1wf7a1MOTbpGLvBhhGnBykShIXSGdd7gUnb1260=; b=ZFrHZppeIRbfIDH5WVMiqo7gPS
 Je0ounebI/xOlC224PQ2ntScKsoq6vF4BRT828v6xL0TL5abMDfvEOo3yxeMApDGklGhgL2+oz/L6
 nEePBgKFW43HGYtK/VT23nWOkYJMQ/16290sxB94pPT5v6byr/B59K2G1YnOzuiRPYAQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E1Ar1wf7a1MOTbpGLvBhhGnBykShIXSGdd7gUnb1260=; b=EDN7/eKSguuwG1raEaO6oadRoD
 LbbXDhlzOqtMJTtG/0v1KhFL7Gepilm6J95yZQNBW9CObSruLgtOLIidr+0gG/VjRMm9HGrGp9UhD
 Q3cxhKl15Xd3VHQh3O+FwntQ9r4cPKN9qP59WpxdlWU8QMnPXJwM2VQzQS9YtZ/oiTOE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pNUKT-0001Ij-4l for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Feb 2023 07:48:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 501B56154E;
 Thu,  2 Feb 2023 07:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C74C433AF;
 Thu,  2 Feb 2023 07:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675324093;
 bh=3P/W3cNG0R5zGI55o3k9s9UzY5c2wN6ZqugQ++IrJo8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qIhApZG4YvrXpm4bMz6tVploZzs+JHkBK1ur4gwYzcPvukdWJRqs4ykQHN35HFddt
 WETXeRpO3v+rAMWXHpwNRZ1UnrJvGbmt5usmXPIK3kTkHLcuKr+M0CmmZdY3lbc99l
 tfPJcKnow2m1oq9gGFzBChrazk6xdvhU6xJmpR43UPOCX7FL5741NqgME6zj3jGJcl
 Liqp5xIfUdhdZwzifmuJcy4Pvy/GyLvoBt069x83dFItJ5Rsq5Sooxil4rIop3KK+h
 uF8pRr8OXWV+wlfjFC5cnem5NznN33TC8eV5VgSFqJ4LLjrVa1MfThACQiDr7VcLbd
 D2cD1H5jR+B3g==
Message-ID: <1c2befb4-6214-b565-48c3-2e71c5e636d8@kernel.org>
Date: Thu, 2 Feb 2023 15:48:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20230201104703.31008-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230201104703.31008-1-frank.li@vivo.com>
X-Headers-End: 1pNUKT-0001Ij-4l
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: use iostat_lat_type directly as
 a parameter in the iostat_update_and_unbind_ctx()
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
Cc: kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/2/1 18:47, Yangtao Li wrote:
> Convert to use iostat_lat_type as parameter instead of raw number.
> BTW, move NUM_PREALLOC_IOSTAT_CTXS to the header file, adjust
> iostat_lat[{0,1,2}] to iostat_lat[{READ_IO,WRITE_SYNC_IO,WRITE_ASYNC_IO}]
> in tracepoint function, and rename iotype to page_type to match the definition.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
