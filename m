Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7A5ECAAA1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Sep 2022 02:55:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oVOkA-0006m8-Q3;
	Tue, 06 Sep 2022 02:55:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oVOkA-0006ly-4q
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Sep 2022 02:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8IoBRdwXmp7h+okYlIIUoD8rKaXxRVKQUjSoz7j6qsA=; b=cT2W98erFa+ONsIV895InBpBE4
 1ykoaiHgolFr3iusllrcFC7G9Ahk3tELQmJ4yXlkcycYDbzVJ82WSCihuD9kFraZmwVTjh3L2v12P
 UfIl07ecKTvWQ3TQAZ9K9AcXAGy0Po0GJ8UiVNaAvjf5tsKmGIFJ7IMhGxLCL+g2YaD0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8IoBRdwXmp7h+okYlIIUoD8rKaXxRVKQUjSoz7j6qsA=; b=JfD4yngdMZIAgp/NdNCmPJs5nz
 zZnERjzH2RLvdhJ6ZQySDgIAOe97yuJSkz0Njo1fpIfKWDKN/8pzgldD1f8VhFGOdt3MnVFiaVZxA
 z5O/MFbpoIio3EwmbPZrSuSULeh+lFeFJ9ehGBYsXP3LtbANbQMii81ITvHSImlmZFpI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oVOk6-0006ky-O2 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Sep 2022 02:55:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5ADD061298;
 Tue,  6 Sep 2022 02:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A187FC433D6;
 Tue,  6 Sep 2022 02:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662432908;
 bh=3vu7/BadoUfwKE+Cvj2EsCAKeAsqTH+1Me+qR/zjgVk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k8PE9kt6sUbSPfAfxrovGYWIW67Vr1Vr3PH+BADB7UWWRCV96K2w5jS57g5WjXeVI
 wziydIX4y4RkJ/MCUneYumzbkUDGNaiVv/S//H9CnlOSHp1LIdGnlSE7s8xQ3coAsy
 tvb6ZhILBUDaJ5zDvzRboKEGKzcMV02AOre+c1VSqEJ6z88qFee2McA3KcVpT51C7r
 oPak2593AGs27fHwFH/aGhtneqRjKr1ilGHBKIKdx7MebZKIuHUHP82DsH2TRitI4M
 kq2+FXdAvkKu2kitU5Sp81+MCReY58enAY+ldSe3uscAMBGjwTrDNYhiSTP7/L5JOJ
 yKq5NHNErycTA==
Message-ID: <de4c9f24-7443-5c07-6fa0-e61d234035f0@kernel.org>
Date: Tue, 6 Sep 2022 10:55:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Zhang Qilong <zhangqilong3@huawei.com>, jaegeuk@kernel.org
References: <20220830065515.101583-1-zhangqilong3@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220830065515.101583-1-zhangqilong3@huawei.com>
X-Headers-End: 1oVOk6-0006ky-O2
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: use COMPRESS_MAPPING to get
 compress cache mapping
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

On 2022/8/30 14:55, Zhang Qilong wrote:
> Just use the defined COMPRESS_MAPPING to get compress cache
> mapping instaed of direct accessing name.
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
