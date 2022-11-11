Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A534C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Nov 2022 10:20:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1otR9d-0000xz-Ag;
	Fri, 11 Nov 2022 10:20:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1otR9Q-0000xH-6U
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Nov 2022 10:20:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6qMa5GpDI/hlHAl6Cx39ErnOEUY53WfcnW0bQywGdHw=; b=K5ESx0QUJPyGBgXWtkyXNYxD5i
 0/2okXuZfQaY7QpxnARA3j/GHZi2p3bK08K5P0L8RJLm51Rpx1qiwifDw2aq0405TQHy60TUYgd0o
 uQriwgYVDXvSu8eEYx/MbDF/uplmcxebW69QpLDjNCPrDxL8MLoAuhHF7xCE52tJlfes=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6qMa5GpDI/hlHAl6Cx39ErnOEUY53WfcnW0bQywGdHw=; b=BQ52QLnlGQQL9CVoHozINDubeG
 ysSZ/uf8h8x5akytWhkkVoquZDJHquGoWY3EVV1Q3KQN4iVtPQCJTPUxfUdprbq3T2TZ47VWV/ZDx
 EdGFeT1f43L/7lYFfS3KnEhHxkfU0PX0Bh7ZJ1GF3hcblADxP4Ecmxq4Kxy/z/t8L4Pc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1otR9P-004ETy-CV for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Nov 2022 10:20:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 043A261F41;
 Fri, 11 Nov 2022 10:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675EEC433C1;
 Fri, 11 Nov 2022 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668162037;
 bh=MvaSTrv8RylylSx6mbqhSZIIc1HuqTr7XT/FG/ZSMW8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kT/w/4Q+34VkdaAvV7KrYgVdkPtC17P0sf0XsFpEsa7mf3lSDrIKvH7LzbAUASfWO
 Ed3e/CkyFJYR2QbRA7UYDjFbFiTH8M/fWcdCwumGUK/O+YJuwJetbMqwCD1h9Dclu3
 rOamB5vuONEBB3gON7gMQMtYsRYtK1+MMqVWVcQjbQ3cMxvTjL3ZrTLdcjw8WKxsMC
 EL582gRwbpf8HnurENxT14/YVX9uTWBp/m/vdHK86OUWo946XyqmujBarlPCOZ6ZCL
 aH9k1N9kwisWnyv8E/4n4m7acsO0NJeEEQVcXd48gCCuc3TWkNIRWZ+ZwuGnqSUIpC
 f1djglQ4lgk6w==
Message-ID: <28030a50-b3e9-e361-ad32-ca26d4756063@kernel.org>
Date: Fri, 11 Nov 2022 18:20:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20221111100830.953733-1-shengyong@oppo.com>
 <20221111100830.953733-2-shengyong@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221111100830.953733-2-shengyong@oppo.com>
X-Headers-End: 1otR9P-004ETy-CV
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: move set_file_temperature into
 f2fs_new_inode
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/11 18:08, Sheng Yong wrote:
> Since the file name has already passed to f2fs_new_inode(), let's
> move set_file_temperature() into f2fs_new_inode().
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
