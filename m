Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60786C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Mar 2022 02:24:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nS8U1-0000un-ET; Thu, 10 Mar 2022 02:24:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nS8Tx-0000uc-Af
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Mar 2022 02:24:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/0y/1QsYTsu6mGkBCK0gs+Kfjj0Wfzaq801qfnwPy2w=; b=FcEr+jtq7plXWw2unDTGD0lYBT
 UQTlS7Hi4ZWhmazwfT2PhsgFAP5ZgGjJ/4XvLpSaPy8Sgc8vrARPUAoCiG7aU8wRazmb8gG/NRxT/
 GDkdRuw01ib/Kwt7QpgeulBi/0mRRK+COSlhd56BiXQ0Y9PeRJ/pzcI3zeVVSkRpsXS4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/0y/1QsYTsu6mGkBCK0gs+Kfjj0Wfzaq801qfnwPy2w=; b=lWPRnd5VHuYeo4G5dbGER9O4RZ
 i1MQx9J6tn68hY+yXiYtJriidXuWGumURGmlgp0J3dfNqFEftVhJZqY4lXQDKiGhIUskcl6rIlBNn
 YfCcrJOibeBsQkt060Ud7f1YNzQBddpYPBYtC/kpq/Dq3bazkFBHlUC+JQXgVo+Pw4tw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nS8Tv-0001Kx-5c
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Mar 2022 02:24:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D910460A6E;
 Thu, 10 Mar 2022 02:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5943AC340E8;
 Thu, 10 Mar 2022 02:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646879076;
 bh=DSBvC9KRS+lSFnVHoR0Lgrqq5hRn1pIOLdtPHObfkEs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rKgGvDdcUTmdOWZj+8bmSYZ0Jvt/ZsTOwj2/YJ+uz4FbZoYXS21hLvhnl9FGmeL1p
 pXnh2phonlREN9R59/xmo8GujyKOS855u+CAEnS72a8wMTjrnGSBZ4ofqyUSw8Pkcu
 9NN5dWm/mKJMleVK5VKJsPfLKHPoHDYG3+tqK7Zljm31ZyBDyxh26WBJmzSyzP6JKW
 GRxGSRlrNrKezS9Qq5dza5+fAD6LheiVPRrsen5c/aukL4bh5deaA0cPMeCO9WOyeq
 oABBCsMxHFSL3Z4LHXc3+HjrAcvMQA7vWpzm8UcSj5wuz4Bu0/vtxC/7I00JBaQMiM
 E/Pvntj7XQugA==
Message-ID: <c5c2306e-e9b1-5b9f-7dca-613844177814@kernel.org>
Date: Thu, 10 Mar 2022 10:24:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To: Jia Yang <jiayang5@huawei.com>, jaegeuk@kernel.org
References: <20220309110935.2059411-1-jiayang5@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220309110935.2059411-1-jiayang5@huawei.com>
X-Headers-End: 1nS8Tv-0001Kx-5c
Subject: Re: [f2fs-dev] [PATCH -next v3] f2fs: remove unnecessary read for
 F2FS_FITS_IN_INODE
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

On 2022/3/9 19:09, Jia Yang via Linux-f2fs-devel wrote:
> F2FS_FITS_IN_INODE only cares the type of f2fs inode, so there
> is no need to read node page of f2fs inode.
> 
> Signed-off-by: Jia Yang <jiayang5@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
