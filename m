Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C824C2BD09
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  9 Jul 2024 09:55:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sR7Zb-0004W4-B7;
	Tue, 09 Jul 2024 09:55:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sR7Za-0004Vs-2z
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 09 Jul 2024 09:55:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t4RO2YVSR/qyEiGi0CRIIee0YC02eTyJoKSnHk8c+X4=; b=ggc7oWm73gvZTEpyXe1vHtia4p
 DDI+/3m9snrz2boXp87hEaj+YrQgXpBicxgTI/NPDFiurEwdOpNPVSpia3VzAUFFvWeB6GBI9t1nZ
 tBJZqWCp75RvikJn2WMAQZZcqFYdjF6kBMOy/dBOSItH0WBBiuGqauYT3ZKJlQ8sfbBg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t4RO2YVSR/qyEiGi0CRIIee0YC02eTyJoKSnHk8c+X4=; b=RrEzhoo414/BiSV3O0DRy0eTpH
 ifKRieWjdB9oL6sUCnC7FmRcSdIWwG0Sy0y82XdZz+9iCCeg9u+MTJM9SOvVJck8babb8ACr/QxOd
 Q5lvI2IXuQKNnweTVCqW2tgYCJwH3WeNWuwKrLJONCKxgKd6ORfpY6FvSfcO36fbLRiA=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sR7Za-00085A-9a for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 09 Jul 2024 09:55:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6EFADCE10B2;
 Tue,  9 Jul 2024 09:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374A5C3277B;
 Tue,  9 Jul 2024 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720518932;
 bh=6zFI12ZFHNI1k59l/Qxr6MAqcx8KpDTNzZoQ3DvA3L8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HXFMrbQMvn2pTvzhMP7+ADsx8/Fzk2aQeI51nHWF47ZVqQ86Qsd1aodMuIrx6ipI8
 JZJjgE4V5JNM5C1b34TxnzKT9MviAMYZcosINDU5R57OX2cAx/eCxKpbjTeNeXvIbO
 36L01RG1jZ8bvqjvwoMy4/e+D0LnaTX3P1QKVS96X86uJWJXaFTN7gva/3NoiJOiLp
 4x8uBa8ThtxtZpsuWFrFiwf1id025GQe3tGAqgNv27k4Ha+qpbsXemqxNR/UWCCRpl
 pR0lK5Ty4u9jeAZLvwR5z2UEqG5Wj7fhjk9m4U0Zk7vJvGRGGwOkNsN5iOBdgZjEi+
 QZNJcClechumQ==
Message-ID: <37db0df5-c39c-4ddf-a0e2-207ad95857a5@kernel.org>
Date: Tue, 9 Jul 2024 17:55:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: wangzijie <wangzijie1@honor.com>
References: <20240626014727.4095350-1-chao@kernel.org>
 <20240709084026.3098260-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240709084026.3098260-1-wangzijie1@honor.com>
X-Headers-End: 1sR7Za-00085A-9a
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: reduce expensive checkpoint trigger
 frequency
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
Cc: jaegeuk@kernel.org, zhiguo.niu@unisoc.com, linux-kernel@vger.kernel.org,
 bintian.wang@honor.com, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/7/9 16:40, wangzijie wrote:
> Hi Chao,
> I think that we should call f2fs_remove_ino_entry in f2fs_evict_inode to delete
> ino_entry in CP_XATTR_DIR list.

wangzijie,

For the case:
- update parent's xattr
- flush parent's metadata to disk
- evict parent's inode
- fsync child  --- we should trigger checkpoint to persist parent's
xattr in checkpoint?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
