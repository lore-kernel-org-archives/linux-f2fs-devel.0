Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90982C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 May 2022 11:35:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nreR6-0007QN-9l; Thu, 19 May 2022 11:35:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nreR4-0007QH-Ts
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 11:35:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QiZBUYxb+LZ8HQ7xupsCN97TS2qlMmW2iQ0cG2KDaTQ=; b=jVOdJZkPQgWzgfnR9zD6tLUUIz
 LwuvntI+27vW2PBmLH5YHRtrU0cPk8hWMzJHaIzCx3cg23yLFCSgovsduNd5fTWlUDBY5uPf9yc1N
 JDqgz/gRKchk+8OMre5N7CC9PJ8UdVCAAF5DBIs2czHrLPO1dw74t/kV4UKOJidzwdrY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QiZBUYxb+LZ8HQ7xupsCN97TS2qlMmW2iQ0cG2KDaTQ=; b=fBBmhnF4TIUkMXFyLpxmlCPA9R
 951CnLLWZ0VgdASyB64Mw+gouZXvHwzCJnY46vA8YeUxmlPy/PuVrERO8X+idDeGXN0JtuziD1jXK
 aXzEnumrAZAUrNJwzSxbri4Am1+rZZ/rIyKcSk7t4TFPkAjI/q5k5obkqv/P7wbEpWOU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nreR2-0005On-Ht
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 11:35:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5ED0D61B22;
 Thu, 19 May 2022 11:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A02C385AA;
 Thu, 19 May 2022 11:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652960105;
 bh=l+UvfwWDbzIpNOrWxSKX1teRaSjmc4rzDjynn+J1lAA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XJRqYvIKuODj6ZGJfUdZPj+xNEUlH9X7Rsdu7MQIxDCHfh3Z02y1Zg0BpdvqZTdmf
 xs27fBxE6B525tsNCbWFlYqzWUZPiZ+n6kaAKfH4nq9GAFk0RV8i2bP5TtaWjOkFzm
 9bM5AEKqAkJ63FXMIyIJ+nOuY8APGA3v0nafC0xBoJ67iNbTsyYP/eWpx59r4BGSnW
 W6XBT02DW7CAXPU6x/xuYQLQgpUUohMr5QqNoBwEKpTznubV1s3l1IDFvrIt1cqwst
 vKiYeI4UzZo56NC8yVdLyMW4PWdH0i6ELDocLb603EzzTvDlh6H16RT6S9Cp++HLpc
 F4eXZ7w7YuVGw==
Message-ID: <893fcc14-6cda-ce2b-222c-2c48bf2275d2@kernel.org>
Date: Thu, 19 May 2022 19:35:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: Gabriel Krisman Bertazi <krisman@collabora.com>, tytso@mit.edu,
 adilger.kernel@dilger.ca, jaegeuk@kernel.org, ebiggers@kernel.org
References: <20220519014044.508099-1-krisman@collabora.com>
 <20220519014044.508099-9-krisman@collabora.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220519014044.508099-9-krisman@collabora.com>
X-Headers-End: 1nreR2-0005On-Ht
Subject: Re: [f2fs-dev] [PATCH v6 8/8] f2fs: Move CONFIG_UNICODE defguards
 into the code flow
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
Cc: linux-ext4@vger.kernel.org, kernel@collabora.com,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/5/19 9:40, Gabriel Krisman Bertazi wrote:
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
