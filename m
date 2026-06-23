Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C947CDB466
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jun 2026 03:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RWsikcCWNAv2IpYMfYBNpLzOmeWVak71NmqyfZDbYOs=; b=fhlOHYiM2htiRK84Ci9UkGVYB3
	AO5c7j5Uvvx2pJA+FhiVU4PPyYm/1JG9Dq5NksJLESnfk3SZkFMbNixV/eHz1AcBN1+vLJXEAFIwh
	G4UbOk0Oa8rt/9waQILgzyL8zS+mmS8KyZj19UCQrpM5pikFNeu01DNnOJWML8sH9sIA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbrvu-0007bJ-ST;
	Tue, 23 Jun 2026 03:36:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wbrvt-0007b6-G8
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 03:36:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JCHnYlVG/7Jpw4FnCw+I3RtmJBZIoCupuIHtQ+K/tRM=; b=Fs2QbJ9PW1JzfaWJVpo1Bp9T7j
 A30SE48W0JUyN66I6Dh/36rlKEyV+tVjvlKllzSedKxWH8YHmJkB1VYo7pkpnvSrEpgafEWHCTSz4
 f+6YNiDRVflA0yyLl9wSXpwDkCKLh7cH5nTeG18qetyHaUicW44AbhwkWd168PrnG9Sc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JCHnYlVG/7Jpw4FnCw+I3RtmJBZIoCupuIHtQ+K/tRM=; b=Ae2J82BcnePKdmdO21jSjwU+NI
 UZTtTHKrai8uCW21lp20Ulbxj+JAbKPgSUGIaJz38BkCmvnw7DDavJbXTuLmyETXIUUWJl8PcaYQt
 EzDsrcCQCNGj5/48jnNwbz58PmefZlpXKNSYzsWX2McxEZrg4u+wuhX5YsFL7vC4tR2c=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbrvr-00068O-ON for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 03:36:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89DEF601F3;
 Tue, 23 Jun 2026 03:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521711F000E9;
 Tue, 23 Jun 2026 03:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782185770;
 bh=JCHnYlVG/7Jpw4FnCw+I3RtmJBZIoCupuIHtQ+K/tRM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=BfEzP9bxaBgtkygivmG4fZ/hpmS5W9t+QMtTkhyDKDpQSAXEF+MYYFU0+tH40l2lX
 ae8YPQ95kjSd2SdF7R7dpBlGvxgFFAw3x4YOwSA5Iscow+AC0MsMIXPfrnAifKwNR3
 EAPf/Bmk6HGyjnPYKdNh4DzL3KG1kzeOh90EA994cBmeX01yCz1dYPhCRRW1wyDxog
 L6VXhgburdJ4lukbnjR4IKZtF3ghIjS5HPLjTbkGnDVVQu+aQLdTpjiC0U4fAqrQ3Q
 nyVLuhwfgOTyCk2yJEW/J4L2trehmhasAI0wjdiRYHTdMmDRrl00ptAs6R8bwyV+BW
 Qx/Q61S0P6yBw==
Message-ID: <e0b1476a-6b51-465d-bdbf-29c37f63ceb8@kernel.org>
Date: Tue, 23 Jun 2026 11:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Joanne Chang <joannechien@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260623032701.173516-1-joannechien@google.com>
Content-Language: en-US
In-Reply-To: <20260623032701.173516-1-joannechien@google.com>
X-Headers-End: 1wbrvr-00068O-ON
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: dirty directory inodes on
 mtime/ctime update
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/23/26 11:27, Joanne Chang wrote:
> Xfstests generic/547 sometimes fail with mismatched directory metadata
> before and after a power failure. This happens because when a directory
> entry is added, renamed, or deleted, its mtime and ctime are updated and
> the inode is marked dirty via
> f2fs_mark_inode_dirty_sync(dir, sync=false). The sync=false flag means
> the dirty inode is not added to the global DIRTY_META list. Therefore,
> subsequent checkpoints skip flushing these updated directory blocks,
> causing directory timestamps to revert to stale values after a sudden
> power failure.
> 
> Address this by changing the dirtying parameter to sync=true during
> directory entry mutations and renames. This forces F2FS to immediately
> queue the updated directory blocks on the global DIRTY_META list,
> ensuring timestamps are committed to checkpoints.
> 

Needs a Fixes line and Cc stable.

> Signed-off-by: Joanne Chang <joannechien@google.com>

Anyway the code part looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
