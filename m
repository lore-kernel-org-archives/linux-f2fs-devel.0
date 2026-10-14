Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7C9CC6B1A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9OJzpkuhmzLJCgrStqaEoBl02xzBnx2KbTHSrDUKXJU=; b=OyokF/Clce1u2T8F/3/m//e+iN
	LgNr8c/zdrX5x2jFi5qsE+/ZsxXh9REHK7sdvz7CUsxdVInTMM32ujHE2byvxgZpJ7jryWDZNKi4S
	2zXPo2ynOy8yk7hAsz6RxlyHhKgFUHMotQmz8OzJEInvoFWLHWnAKvr/MVUJhl2l8lnM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGxne-0000zb-Vw;
	Wed, 14 Oct 2026 12:09:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGxnc-0000zU-Mg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 12:09:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mFWfOSS5lvfx7vga/WWDPCNnBR6cUwPgQydOg6nfUYo=; b=jNam49LwpsFaBEF6ZZPYrgdu0I
 xm4xhP10QNFoipWcY2hypMuxgV/+UQ0D8LvgzSmqho7bqGWs0/2FbVUnCE017oGRf2du6fcgVK3Vn
 vn2FwZ1rrahSOXt3+jzUCKdfxAldiMHgzDcjMQSL/td7dxfz1svnmGxfeNyr2Ub6amT4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mFWfOSS5lvfx7vga/WWDPCNnBR6cUwPgQydOg6nfUYo=; b=PbWY48aDI3B8RKrUTmp+B5a9zK
 tXeIcdxUstlciXsAXdDEttjsDqVJGx27OGryJkfFefUQEqlZgI0Funb2sqa3nwjFbNp6F1MEAQo7l
 Ux+c0M3MEKlxUqnxExHbkJTGvifpq/pQlZeygLlWIX96wNJq8Eu+jZ7oCI3sZ980OfO8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGxnY-00008K-Eg for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 12:09:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 035A843B54
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 12:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60231F0089A;
 Wed, 14 Oct 2026 12:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791979766;
 bh=mFWfOSS5lvfx7vga/WWDPCNnBR6cUwPgQydOg6nfUYo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=F+6i16WMxMQCyRdokR3qBU4HvjcaOkRaKFOjUIH3ujeHQX0mUD5kJMJ1lLoZ678/D
 M+btFvZybaX0jzHKOdNUa+NuFXtA6rs8GpRPDl17NpL6WGGRam9LytRn2gak46ETTZ
 GwauBt/KV2KSeDEIF7Sut+VAJRrcKHiUqzADXWvxvqt3KhK1ClZdlP12qmnwCnIqGJ
 FZcFYTp5hRterYgyQEEIF5qmJBvN3TT/FFOvvuYf6Dy0DwJg6OSExf1RtAu8MepcfL
 zDn8XVoPeX7TGc4LZHKrNN7YjRt6yxdAEpRKWT22bKcikZRBTG9Z+EJ3MGxF6UnJ2o
 PCZRDo2DJ943Q==
Message-ID: <9dca283d-1051-44c1-ad0f-dbf5d4519a51@kernel.org>
Date: Wed, 14 Oct 2026 20:09:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jeff Layton <jlayton@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261012-mgtime-f2fs-v1-1-a934ef646c44@kernel.org>
Content-Language: en-US
In-Reply-To: <20261012-mgtime-f2fs-v1-1-a934ef646c44@kernel.org>
X-Headers-End: 1xGxnY-00008K-Eg
Subject: Re: [f2fs-dev] [PATCH] f2fs: opt in to multigrain timestamps
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/12/26 23:46, Jeff Layton wrote:
> Set FS_MGTIME on f2fs_fs_type.
> 
> f2fs meets the multigrain requirements:
> - ctime updates use inode_set_ctime_current()
> - f2fs_getattr() calls generic_fillattr()
> - f2fs_setattr() calls setattr_copy()
> - s_time_gran is 1ns
> 
> Exception: with CONFIG_F2FS_FS_POSIX_ACL, f2fs_setattr() uses a local
> __setattr_copy() that sets timestamps directly, bypassing
> setattr_copy_mgtime(). Make it call setattr_copy() with ATTR_MODE
> cleared, then do the f2fs mode/ACL handling as before. ACL builds now
> also honor ATTR_CTIME_SET via inode_set_ctime_deleg(), as non-ACL
> builds already do.
> 
> Assisted-by: LLM
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
