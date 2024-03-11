Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A95AC5475B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Mar 2024 10:23:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rjco8-0006oQ-Fw;
	Mon, 11 Mar 2024 10:23:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rjco6-0006oH-Mv
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Mar 2024 10:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YvzM3BBNPq7PQ1sKkJH5WYWafUPK5ZsWj/fFwcqWaJU=; b=iUoIMcv90LlfttB2+X92b11eiX
 voXM9sO6g+OO4J2St3ZbLYsEKI3iBc8sbiWdXJRkBbRnHDDmy7DuXfDxgp/tHWp8ifsoqvM3e2jin
 WPRoVVNx/LvEWDP3V8+tv3SfHiTRYjdtCbsauAWKPM8XQhBPoqb0dLXBXBOkecl/Vg0k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YvzM3BBNPq7PQ1sKkJH5WYWafUPK5ZsWj/fFwcqWaJU=; b=LdhCAU8k4Ycu7ad06eJwbVm33y
 Mp5twzEqLKDihCCue8VUAZ1q7Z4MWIN0qXViz7YnlP7kkS2cK9uNxohv3HMvmVuf0R2MxjFm5uhCk
 Wc/NczLx8WKaRstWM0uJIHn6+s4D9vWx11xgw67Zt30ExZf00+89PwHfl65oYgap2bK0=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rjcnv-0006ol-8r for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Mar 2024 10:22:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 86C1BCE0F4C;
 Mon, 11 Mar 2024 10:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B06C433F1;
 Mon, 11 Mar 2024 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710152560;
 bh=NNHHZLyZv26sgBeGxvdVNmM6HJZ5hj9Zl2HSEx5V0/o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=st0YsnIN8DGk5svq78mSzUHDC3atE+DJb36P7okTncDE9FmR1rqvKST3bgJya3zEM
 oMQJOKTyMi5spTD/HVc9cpSqAL5FO4Zr31VhUGOXZxf0LVryvMSo9DOqdT1QcRTlRe
 roY7k3mTBTMzxitaPXdiQFaEjxbjXSRr7hPNS6iapQYlhRaBa3GYh2/Lq/+FgfSkqp
 iisPjzvpm4Xy3y1z+vGBFVw6Uw8Hy/Fe3ssE30pj9UfnVeWNyMlNOQGWDeXe7pez81
 Dd3GK7qpfd9PBnixfjmc702E1FZ9IDe/XYXNZE918RKD9lNNkDt4IEx+moF9+rYNIz
 CypmM57h/jlow==
Message-ID: <9c68f756-5ac9-4074-a374-d62b6671f72b@kernel.org>
Date: Mon, 11 Mar 2024 18:22:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1710143334-27653-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1710143334-27653-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1rjcnv-0006ol-8r
Subject: Re: [f2fs-dev] [PATCH V2 2/2] f2fs: fix to handle error paths of
 {new, change}_curseg()
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
Cc: hongyu.jin@unisoc.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/3/11 15:48, Zhiguo Niu wrote:
> {new,change}_curseg() may return error in some special cases,
> error handling should be did in their callers, and this will also
> facilitate subsequent error path expansion in {new,change}_curseg().
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
