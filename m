Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA6BC28B28
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Mar 2025 03:28:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tsCm3-0005bV-UH;
	Wed, 12 Mar 2025 03:28:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tsClw-0005bJ-1v
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 03:28:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rb269HAgWD2khN36YGd6sHBpnFOKFKBKi07OYBHydE0=; b=f56ou68eJMJAVbL4NTl7rleWoJ
 uNMxTXLZ5sBMFsZ1kk/9lVhN3cmkncsaXi2YReW6/KI9yGygnff420b208j/00hRTYQbWVTxzQ/1z
 BtqXiD1nwSkxPYrh1XU97W2lZWzoeH+9ocQX99oRyn3mjHeYjsDIDLwPoapaqKVm5VfQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Rb269HAgWD2khN36YGd6sHBpnFOKFKBKi07OYBHydE0=; b=U+LFm8vyuZ/F4uGOj+dJWtUYWq
 WQaVjug2rYTVjpn2glOoHTU/CIT4IWfBV6pBl4kjyKll76gOYIIkqVtn4sbZjhUiWOSi2+ruV2zXr
 +xMK0jejHR3wDTrsVzw2vjxJkJ7fWG6X9pNY2sg+wX2s3/pnD9zizmIBXBOMyuUpBpYU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tsClq-0006pZ-FC for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 03:28:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4E5ED5C4041;
 Wed, 12 Mar 2025 03:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA16CC4CEE3;
 Wed, 12 Mar 2025 03:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741750112;
 bh=PxOjlGXYsgg1sfrevNlsLNEO99vX0xRmnLsLL6VicX0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=uMQN6AyWQVvgwWI+4qw+lfQtz9+G6FLfTx0xm7UIHiQJ/oMIe+NtwWEotvMWyI9W2
 a9Lqf+8E/WwFWM9PNSv+jzidILlibZ9prsMDjC6IrmjoLG2TnmIjgPajdSv7iSDFtS
 towLhOmlMLrMRKZ3TloaT7/J6rtF/6IOtgtml4mRaPbK8EKgfFhoNaJ+hWdsS6Juno
 CrrG02tdRSZ3FmPHSemCWXlke/0wdiQVPxRwr2JcUc3xcCMjphYOdkR4o2NeBZYLG6
 OPLFg+ojIjSZweTDI4LLv9YEl74+q9fGu7MqjRVRUaDLydEblebP8G7J2L1OhFMKNy
 Qazde3YH2tDPw==
Message-ID: <d46a65f4-e755-4899-aead-bc2bd4f69b00@kernel.org>
Date: Wed, 12 Mar 2025 11:28:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250303172127.298602-1-sandeen@redhat.com>
 <20250303172127.298602-5-sandeen@redhat.com>
Content-Language: en-US
In-Reply-To: <20250303172127.298602-5-sandeen@redhat.com>
X-Headers-End: 1tsClq-0006pZ-FC
Subject: Re: [f2fs-dev] [PATCH 4/9] f2fs: make INLINECRYPT a mount option
 flag
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Eric Sandeen <sandeen@sandeen.net>,
 lihongbo22@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/4/25 01:12, Eric Sandeen wrote:
> From: Eric Sandeen <sandeen@sandeen.net>
> 
> Set INLINECRYPT into sbi during parsing, and transfer it to the sb in
> fill_super, so that an sb is not required during option parsing.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
