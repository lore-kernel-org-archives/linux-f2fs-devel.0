Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EA0CD5BC9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2026 02:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qmMgaibJnKsUymdJ6XvkGCsfjHze+M45Q06QCViWBJk=; b=DP88Z/US+J/22hBbz4cMNvbIkN
	dsELbih2sQKtrwOkX/hQ5oDm1Mkh565V9QyVbG/qlrQHsvBaGNFSMOh7oYJKCQA89QtsgkClBsMAi
	8JgZjUUY8DNjuv0trHYU4C3qZHrrY/kQWMPiTBT4Dzcr4hJpWwLSt80PsicCzrk7Dy0I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRhJG-0001jB-Vw;
	Tue, 26 May 2026 02:14:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wRhJG-0001j5-IK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 02:14:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vMJro2FNfSWiXVq4zv/1oscD0Kiggb0QURyovkKp3M4=; b=BIYzK1031AE5JSCl6hxEuU6frH
 /TNtQqh64D/P3hoMYv73HOzWNpTZh2AbCdt6/1RihL/2vzQrL0DqKnabSOE0syHEpdqLExePFYuwS
 I9lE6Vll3w+p2ePOAC+SVv42tuL7/dOOAbKzQsSWUa+QCH2leLwancvlGZ+ynMeiOhQw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vMJro2FNfSWiXVq4zv/1oscD0Kiggb0QURyovkKp3M4=; b=Nt8zwqTNKRl2q+qvujLuswr1Er
 UwKHg4O4jBfK2DdQMbVC56FRG7cpuA0l/UByPrO1VwGGYz5+pzs4Wm3jaAFvr1bZnQ4x1NP0na8oY
 86Be8bTT4LBP345p7RcqE40OftN9wJPRMcnmHYxrwnu9kE6QgWhzT8xjUtQTz/cQKJz0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRhJG-0002Ts-7i for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 02:14:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 165466008A;
 Tue, 26 May 2026 02:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6051F000E9;
 Tue, 26 May 2026 02:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779761651;
 bh=vMJro2FNfSWiXVq4zv/1oscD0Kiggb0QURyovkKp3M4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Ssk0v4lz3YeeRI8Ax/t+GrgAl3Zbk6IhgXLgK1bNbk0ZW4d8/Mp9mYmFLiTZkBOni
 JayrgcVzthtkvKowz8IF721ecQnbWnGwDZTrA6laIU8A2iIKQnEEuuoCce2hTI0sru
 Sd9TaAZVXsoLAjkQU/MG8biNt3XQcM/JC7HsPltZOiY2yqE1xwXyfTbOSZB0Fys+ai
 oyepomO73yu+7grOLnpnxVxBAGDYvYShozW+kKswJe6+ob6CfrdnPTao6/3S7XFd/v
 9pEpeeLO+jszJkSY4U4SYT0mS8L7CJ12TAlAwB5TYsWjGTTs8BNff+zlW9rsPrnIKI
 461MulTLE8QPA==
Message-ID: <d39cab7e-ced5-43f1-91f4-46db41e8f020@kernel.org>
Date: Tue, 26 May 2026 10:14:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260525061456.231710-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260525061456.231710-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wRhJG-0002Ts-7i
Subject: Re: [f2fs-dev] [PATCH] f2fs: stop checkpoint on compressed write IO
 error
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
Cc: yuchao0@huawei.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/25/26 14:14, Wenjie Qi wrote:
> Compressed data writes are accounted as F2FS_WB_CP_DATA because they
> write compressed pages through fio->compressed_page.  Their end_io path
> should therefore have the same checkpoint-stop behavior as ordinary
> F2FS_WB_CP_DATA writes.
> 
> However, f2fs_compress_write_end_io() only records -EIO in the inode
> mapping when the bio fails.  The filesystem can keep checkpointing after
> that failure, so a later checkpoint may persist metadata that points to
> compressed data blocks whose writeback failed.
> 
> Stop checkpointing with STOP_CP_REASON_WRITE_FAIL for failed compressed
> F2FS_WB_CP_DATA writes, matching the ordinary data write end_io path.
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Cc: stable@kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
