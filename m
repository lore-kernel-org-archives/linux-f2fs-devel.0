Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E75103E166
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O5Ay0beHE7Sfk9UD3QMyPlWvHOD6rgrbKBREgLBm9Ps=; b=Fmrn5+9O8yXHZBr48VL7msYkQA
	yBrh0nddqbyxrKfwkyetACTF8a+29dYrT6wWXuVmEMhso8EJcD5Z7aY0Z/42UcI65xf+sW3yjnLNr
	+9ZKHcq6ILIlUI2ejV2y52iwihdRJ7dBtYgjZNkXNj9kp18cH1z6gxvVHiYCHNyqwbyc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w2pFL-0004ca-UO;
	Wed, 18 Mar 2026 11:39:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gregkh@linuxfoundation.org>) id 1w2pFK-0004cT-7R
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Mar 2026 11:39:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o3RhWqo0QtWDwtRAKzC+HHNe94jMrn2VMNQAq/3bxOM=; b=dPfIr9GGPN4Wadd8rz7ybGa91q
 x42yzXroZodxbYpQ++20nErJT1wFr1FlhSXxCzP5VEbSmpDRULOhWuWp6o/sBLW1ottseXxVAPJTO
 1bJPfDR2dpBGMFAYw80nFta0Q3WnZ8LyXGYw7qOYMnAcFez1gpoUkPfeKDNl+yd2JU/k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o3RhWqo0QtWDwtRAKzC+HHNe94jMrn2VMNQAq/3bxOM=; b=hILcBZkQ+mU0RPwP9W7e0Vmiv9
 6WOavGw+mV2pYG4YUxjDEYlaAQBe/h/tma9CvJLVqC5h6iuB5OQWnaAqemE1AdJ4sP9RpRVlkJeit
 J9FT9VkwrbIEhzr9xU2sbcFucNSzHDpxz86GrLpJUMIutiorjS2gAtNo3kRmCeRqQMNI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w2pFJ-0003sj-Kw for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Mar 2026 11:39:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BEF4D600C4;
 Wed, 18 Mar 2026 11:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BDBC2BC9E;
 Wed, 18 Mar 2026 11:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1773833958;
 bh=V34B6isW0gCZivCi9M0hWAynRG/F8saYHB58i9fTKSQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D0EW7el+Q9Is4m8ixpYvpiRJdL8voWmgeioPHQaa0CLTYlD8dP5bacdSma20K2QQ3
 GVxSvbjXGkOzwoxJpw0W1IFW3fjNqel3CIl2nMoj/oklkMpAQPwU1yCE9cOKAzAf3p
 5QRvgmfJoUFuq0FujpU5+uCO+oIGMp0m+oPEhTvw=
Date: Wed, 18 Mar 2026 11:08:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: ZhengYuan Huang <gality369@gmail.com>
Message-ID: <2026031816-numbing-unsorted-f21d@gregkh>
References: <20260318090410.3368669-1-gality369@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260318090410.3368669-1-gality369@gmail.com>
X-Headers-End: 1w2pFJ-0003sj-Kw
Subject: Re: [f2fs-dev] [PATCH] f2fs: reject non-directory inode in
 f2fs_get_parent() to prevent null-ptr-deref
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
Cc: cm224.lee@samsung.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, baijiaju1990@gmail.com,
 zzzccc427@gmail.com, r33s3n6@gmail.com, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 18, 2026 at 05:04:10PM +0800, ZhengYuan Huang wrote:
> [BUG]
> When accessing a crafted f2fs filesystem via open_by_handle_at(2), a
> KASAN null-pointer dereference is triggered deep inside the fscrypt
> inline-encryption path:

Does the f2fs fsck tool catch this issue when run on the corrupted
image?

> The bug is reproducible on next-20260313 with our dynamic
> metadata fuzzing tool that corrupts f2fs metadata at runtime.

That is not a valid threat model, sorry.  If you can modify a filesystem
image while it is mounted, this is the least of your worries :)

thanks,

greg k-h


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
