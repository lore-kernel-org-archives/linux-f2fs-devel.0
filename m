Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE08AECAAA1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Sep 2022 02:55:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oVOju-0006l9-9a;
	Tue, 06 Sep 2022 02:55:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oVOjl-0006kv-Gv
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Sep 2022 02:54:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1X8SRWDZUo+S/MDa9FwuGplAPL7yn/VXH/J/Yg+0nPM=; b=Jmv/do9v20/Wb1BxBF9u051Gqc
 sNlwGPjQ9qO3SP/761ehZVVlhpa6h8Kv+mK2ONPSD4yTsBxsVn19WMkffYWqkX69330VHRv/+dZMB
 HvZcSsh6tJM9UkSqBE/Z5K4hjKWe0F7ngYiwmezcDdcqP0HSHfQZUPU4l4K/vFMXf/Eg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1X8SRWDZUo+S/MDa9FwuGplAPL7yn/VXH/J/Yg+0nPM=; b=M+ptg+dgpqrQ2O27MfWVwbIeDc
 eP3UenHBTt7wx4cb6xImytA5GS1QhhBdOgkG0d8Y06hC2vHmoLhGGG1C+7ntvAOTUFzWMLZ055a6h
 RvlXFojNCqaDT8N0nzB2Hdzz35Fbpx22vbMcCNjn1lVIFYFsUhN43RY66vMGYTg0+V5s=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oVOjk-0006jO-Pp for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Sep 2022 02:54:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B2220B815AE;
 Tue,  6 Sep 2022 02:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E01C433D6;
 Tue,  6 Sep 2022 02:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662432884;
 bh=6WIcMluyxNjE8x3fl2dFmcG7nSMpoSTJHkESgINOdr8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=H+JHwTKdBxD4mxBXYK59TMtJ+f6nu0TbR1pTMO0wYh6wkXmix/k2HIbx/FQLESrtL
 7rVwc7sRn1R11N3ZaC/3mVacSfwV62MwJprc4PDOLU+G4MQtYioYpPgJZqE9dT9kJ7
 LzD2sJuMpP6NUiL6nUPA2shAeiQszqsuHcofP400DcAyDYbXD/tZOjrhxs9vIdouVX
 pEetbCuUV5XIIauS36k3ZXfWvMELuG8VCQsYHtZFdKnTpibEdbLTm73CbtsfXo76fS
 m/6IcmTD0dcwkFIDe2d5XUQxgpfR/0lDh3OmrE2Pq976c4qt5lVmvt89WP//bfpICk
 mF9yBI8QFqptg==
Message-ID: <ecca60df-8932-7d6d-7bcd-e415e29d7c93@kernel.org>
Date: Tue, 6 Sep 2022 10:54:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Zhang Qilong <zhangqilong3@huawei.com>, jaegeuk@kernel.org
References: <20220829133120.100373-1-zhangqilong3@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220829133120.100373-1-zhangqilong3@huawei.com>
X-Headers-End: 1oVOjk-0006jO-Pp
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: replace logical value "true"
 with a int number
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

On 2022/8/29 21:31, Zhang Qilong wrote:
> The "true" is not match the parametera type "int", and
> we modify it.
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
