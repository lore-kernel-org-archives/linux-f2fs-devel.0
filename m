Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F3BC61DFD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jZOhtn67Pf0hOG/hSTPqttM0HXpqDqm+DEbku+BC8uI=; b=iNvleQZ+TPwWQe+XoqtQQ58x6E
	L4JqhlfP6M1YJamYh0wY1M5oUn5qu9jd06oEiQhJxzIWIxzu2MmtZowHSYkkeayr6QGSmkoX30WGr
	9Pf5O72LltBUGQitYQetkx9ZsentDT0RNV82jZ/Iy9eKAp5fZrhL5QE3r4BSvGDhB6zY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1hL3-00086I-0r;
	Wed, 02 Sep 2026 09:33:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x1hL1-000868-Ek
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 09:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sLNkN45zgCTnCwe7uN6wLY+RNmxWk6frEwpG0oaL1aU=; b=GTO/IjLgbCDvt04czdwws9ArnR
 j4L1PXenP0b/LWy4uu6HP1+mAxGqzUBWN5RbzP7m6Qwh8lRwBYk2HzUnDfi2muogsOFwjaAnpjygA
 g0i/iIW6kEF/r3kRoh2Y/OqC0irkMDotB+JPfmF0HvNGuXEXi9gLu2bBzQ7JSQH7KVCA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sLNkN45zgCTnCwe7uN6wLY+RNmxWk6frEwpG0oaL1aU=; b=i8AjEusjqGYspeNmqoE6aGiIO0
 6MKh+9tNnHzMWawfxeqZVmMTTnS384lyIPeFjvdPYMpfipEXSWwaVSKvZXfL/uZAN+vCW7GERUJ+J
 Cwftj8mV2dlgfscRr3joecKAHlwfzjvXpAHZfWAacpqN3Kl5vSJcPl8zMFg1K1b/WqD0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1hL0-0007UW-Ls for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 09:33:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCC50600C8;
 Wed,  2 Sep 2026 09:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1891F000E9;
 Wed,  2 Sep 2026 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788341572;
 bh=sLNkN45zgCTnCwe7uN6wLY+RNmxWk6frEwpG0oaL1aU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=DS9oslsq7i1jpGVXJ0KnNOxZQkn9Uk/+7eR3lYTrD6crgklC+XzVtiPCaxsi7eWxv
 afk+WuI78ObkOCdSh4sZ5FpscfFKd4lbJ5cDYOVyFKkC8SpRN8HB2ljwa0+qzTv+Gl
 d5e7O91XRNefR3KrrMlLz3iqu7kjcAonL4XUboexYMmW3JxZ4p8Z8bR4Xn5h7RVAG+
 HoCSTrnFyUZSMWn6Hr92AREnbWcrHh34jp0AwIm3gpCEF5ENzY36cDqhJbqUiqaihA
 FC98JQ3QPhK9nfP5aEl2+pFnDD9T3uCybV5d8WI14lcYKnTamCgxYRH/U1roN/4R0R
 0KK94W4n/rADA==
Message-ID: <2c4fedee-7cd8-4377-803d-a3b5406bd003@kernel.org>
Date: Wed, 2 Sep 2026 17:32:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260902090611.564876-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260902090611.564876-1-qiwenjie@xiaomi.com>
X-Headers-End: 1x1hL0-0007UW-Ls
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: wait for inode record work before
 clearing ino bitmaps
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/2/26 17:06, Wenjie Qi wrote:
> APPEND/UPDATE inode state recording was moved to the inode eviction
> workqueue. These entries were later converted to bitmap values stored in
> XArrays, but the workqueue drain was left behind in the list cleanup loop
> where it is now a no-op.
> 
> During unmount, inode eviction work can therefore remain queued when
> f2fs_release_ino_entry() destroys the bitmap XArrays. A delayed worker can
> repopulate them before the workqueue is finally destroyed, leaking newly
> allocated XArray nodes when the F2FS superblock is freed.
> 
> Wait for APPEND/UPDATE inode record work before destroying each bitmap
> XArray, restoring the required ordering.
> 
> Fixes: 9a9ee7408a1f ("f2fs: reduce memory footprint of ino management")
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
