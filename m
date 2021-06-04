Return-Path: <SRS0=ofO9=K6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9A5C4743C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Jun 2021 23:46:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134A7611AD;
	Fri,  4 Jun 2021 23:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134A7611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lpJWQ-0001E8-J8; Fri, 04 Jun 2021 23:46:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1lpJWO-0001E0-LO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jun 2021 23:46:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2haOJsKpbCYtaUPAIUi22h4vcw2RpCYdb5AwRIX+PRY=; b=icgZylEiqxFdW1rf7vzmLticQV
 yMue4efu1dPHBu910WDet+1QUb5WNfq8Hqe4Bv0QrEJ9Gi44QNU0Fit3DvF4Uu7KXagI/X7bRilWr
 5g1Fo1Ebcobwz2oZUT2XXjkFd9AcMatDEcVLkIs8E0ErPeOYHJWN2ZMHtTf1Emr1hsoQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2haOJsKpbCYtaUPAIUi22h4vcw2RpCYdb5AwRIX+PRY=; b=Ml4UuLbEx/RWOMSizIWuvs4pJv
 l2FBII7FPKzZYdHyffY3kdBNwdTTxmQMWLem8a608o7Gc6+NlPqmRkoug2GK26yMgRgrsX+Ew2GXX
 jxO5/LG87/ZxuSsqwsYNDlYNpzbIpZyxCeQxeI6bg5k0iGZKarleMHgp6a2/3js9rlQg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lpJWI-0004Gc-4q
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jun 2021 23:46:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BDBC613BF;
 Fri,  4 Jun 2021 23:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622850379;
 bh=dVAsj97VPJExVgGrdFq6Ldjte9Nsu5o7m/Jf4r28Pps=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=IulqhdVahvfo+xr3LJlYa8YVEWi36ultY/bi7bS2Edbl/pDTB3oM4BeWPc/VSl8hd
 47U4pEY+SLhs8wwGEMdoNyUkzK2Kd6InWHugqRoXsnm5/SzJjhjlgM/bnlfj8mX304
 QPs8kpvwAw4L+eDaytjzlfEEHq7KbIyQlSpXcuAsDFgAeqtbCBJ5EvK/071ggPgkot
 7Y7lCH8W7O5cjGeSFYRbg+EU6QaeP6ub5nwdhrda+MnyzUnCRRLbU/rymHfIt3WrdF
 0zRb6vcAg5S9AD5pjdaFarjKQWTX5bkazMlHqGEb9YousZLTsgyW0m75d4BvRar+Hs
 z8oZQcfV94EXg==
To: Daniel Rosenberg <drosen@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20210603095038.314949-1-drosen@google.com>
 <20210603095038.314949-2-drosen@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <c0df4ead-7bb6-d9e0-db3a-58d4db1fe354@kernel.org>
Date: Sat, 5 Jun 2021 07:46:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603095038.314949-2-drosen@google.com>
Content-Language: en-US
X-Headers-End: 1lpJWI-0004Gc-4q
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: Show casefolding support only
 when supported
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
Cc: linux-fsdevel@vger.kernel.org, kernel-team@android.com,
 Gabriel Krisman Bertazi <krisman@collabora.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/6/3 17:50, Daniel Rosenberg wrote:
> The casefolding feature is only supported when CONFIG_UNICODE is set.
> This modifies the feature list f2fs presents under sysfs accordingly.
> 
> Fixes: 5aba54302a46 ("f2fs: include charset encoding information in the superblock")
> Cc: stable@vger.kernel.org # v5.4+
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
