Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF89ECAAD1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Sep 2022 13:45:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oTkVq-0006DF-4v;
	Thu, 01 Sep 2022 13:45:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oTkVo-0006D9-Kl
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 13:45:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=orc25NX/pxPVOGOvmGVAVjqqqXrjYvViJBob0e96dlA=; b=iX9FBYyOBhMGJZkq77/ZIy4TZ2
 cNlTsYNGcmgQ6bSodQEj8puSwtU8OFg6sJcOA5AOS0adAOxs2YBLIrEZi3G9elCQAAEJakFHA1w5+
 7UjQCFNVVQy/sFUskTuGj1fNKq1j66UT1T4qJGvMLlTfKvJnuqtKl2C+8ECMfH60YXHs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=orc25NX/pxPVOGOvmGVAVjqqqXrjYvViJBob0e96dlA=; b=T7Vw/WLIHZcmhTKJd+1B/hUshM
 ljPn1RZ33eJ5JPsLiJRMDbhn/44b116+3heJmVQaBgUDFu2YECBYz4PaGWDxKwsYYIy53mBqNNOBF
 sG1Y4uJ1rI2MQt2G8H0iNGCODipLJlDu9HoNxFDbszUqlsNZ2Wir6KVd/9Gi4L+kjzCY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oTkVi-0004Yc-Iy for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Sep 2022 13:45:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 680AE615B5;
 Thu,  1 Sep 2022 13:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6457C433D6;
 Thu,  1 Sep 2022 13:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662039927;
 bh=NRvuECJZ1ZIktPfcTXTV3+ChJtXfJAluhGj5ipxRwy4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jWsdkbizZxUcsLEOPBiRqZbDhBdAPLWZnYq1hnwQTgfQqva9lkU724WdoIzvQ1VNe
 3sADrDJi5IsH+KWG28pOgPPSCMcSmx8qH+fqXjnNfaplnEwHYmWjLAgKjunwyD75ZE
 Lq5rLrENzW1sTNCJMzsFiYbKz5uv3Se+k8+CA0i5PzwbH40jOQ90T783XaX/PQUgGX
 RoWeS/OTJZpcRoAo7QGaOtmL0Wb6PUtZeo/HobB6fmvA5R+DuYQLi0I1nQpXgx4KUC
 Bz2CA8qzUNOIJLvohvWPmQ78sovalgJRYLXG/xVbc6cjAFOKr3Od/E9qGEm0b37P8/
 s5EM361MdcvvQ==
Message-ID: <66905356-e742-365d-f708-44188d053ae3@kernel.org>
Date: Thu, 1 Sep 2022 21:45:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Weichao Guo <guoweichao@oppo.com>, jaegeuk@kernel.org
References: <1661935106-4851-1-git-send-email-guoweichao@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1661935106-4851-1-git-send-email-guoweichao@oppo.com>
X-Headers-End: 1oTkVi-0004Yc-Iy
Subject: Re: [f2fs-dev] [PATCH v2] fsck.f2fs: use elapsed_time in checkpoint
 for period check
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
Cc: zhangshiming@oppo.com, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/8/31 16:38, Weichao Guo wrote:
> We now use walltime for monthly period check. However the walltime is:
> * unstable(timestamp register reset) and settable(modified by user)
> * unreasonable(e.g: device power-off for one month, no data changed)
> 
> When the walltime changes to the past before one month or the future
> after one month, the period check in next fsck will fail to skip or
> start a full scan. So, let's use the elapsed_time in checkpoint as
> current time for period check.
> 
> Signed-off-by: Weichao Guo <guoweichao@oppo.com>
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
