Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0723ECA9EBD
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T90oubZOxpMltccOAWaUMEsnaV4FkOlCNMXyF+Q+mdw=; b=QlsVuS3RWg+4px1q0v571QatOL
	KRBNw7qJO3rf7kmyiO+5T8crCnD3m4s/ZbqhNC5JwNb/wOH6L2sZQB+1lhNFLQcIB1R7yeIkikgBJ
	b1LGny4tctdkqvmCFk/GOiYb6+dja+XXfDmdLRXzcJSAUJ8t3CB21CHHwNIEubeAoe4Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFqwu-0003Ha-DC;
	Sun, 11 Oct 2026 10:38:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFqwt-0003HS-Ci
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 10:38:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4X2c8KnPvY/fWVDV6z/9cBUZlxLIVOezpXC3qPode2w=; b=DgiM681JYqAGpsVnz8pw2prFx8
 l0LyquqC3i/r1um8HwDo1td6+Xb0peGSoAQdbqHKBQi1ie8Ly0Vvysel023BKYW4lIphIVj8yvDuz
 2ZIZgr6rHKKMv2Et0dyGR955TPMOblZfjhVqkAFKSeJ8u+oOwgAvoQPphtzB8UnRgDhs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4X2c8KnPvY/fWVDV6z/9cBUZlxLIVOezpXC3qPode2w=; b=i07xg1550SFkAfLxLjqJdvVYU+
 x5C4fjiZT/NEO23bq68ryGtZtNjKz4CuqLC1oAXR1iwfFcnSfanOuov6f4skid/b6tFwEqt1NUVL3
 SMs9HiNFMWeGaoXSJToWr8ybJ9lKwU4k1GXF7Sq1Q8ufkOgU1P1ILsyS96XFcx0IT6j4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFqwt-000182-Jv for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 10:38:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5355541292;
 Sun, 11 Oct 2026 10:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBB41F0089B;
 Sun, 11 Oct 2026 10:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791715110;
 bh=4X2c8KnPvY/fWVDV6z/9cBUZlxLIVOezpXC3qPode2w=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=cYC2D8TuYXCDsh9S44XarmjVFNrpEJQ6VdSgMk1ycFevLEQHZQBalgVvkDWAbZIjB
 9Q6jvzWmPzRS95y1bi9O4vOyWN++RpVTPfA/r4QyorSqtZZqzosMEZNpSs89dhXbcx
 kMxakjnojm3xbd0urX0mXkz46y8i6Kk7VuIt8N0G5EMHoiM/iB0BsSJ+Iuy+MxsVYe
 E+L+1p6R2hln7QGcS2AP2b3rNgoGQoOUkTTjOIifLzwjG0erDTzP8UYebLNMCsPtdk
 1MCAfXJpW9KyzoGTzuov+eY1KON3B235ONifW2smfOLRoqvwB1YcJ8HEyPqpDDI/tv
 GWNJhHN/no9HA==
Message-ID: <2682e98c-826a-4fc5-8184-bf9b8a20abb7@kernel.org>
Date: Sun, 11 Oct 2026 18:38:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hengyu Liang <hengyul@cs.unc.edu>, jaegeuk@kernel.org
References: <20261010165750.509939-1-hengyul@cs.unc.edu>
Content-Language: en-US
In-Reply-To: <20261010165750.509939-1-hengyul@cs.unc.edu>
X-Headers-End: 1xFqwt-000182-Jv
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow empty strings for journaled
 quota options
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, joannechien@google.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/11/26 00:57, Hengyu Liang wrote:
> Commit 2a3db1e02ce0 ("f2fs: allow empty mount string for
> Opt_usr|grp|projjquota") added support for passing usrjquota,
> grpjquota and prjjquota as flags to disable journaled quotas.
> 
> However, it also replaced fsparam_string_empty() with fsparam_string(),
> which rejects an empty string. As of now, mount(2) and
> fsconfig(FSCONFIG_SET_STRING) reject usrjquota=, grpjquota= and
> prjjquota= with EINVAL, although these forms are still documented in
> Documentation/filesystems/f2fs.rst.
> 
> The issue can be reproduced on an F2FS device with:
> 
>      mount -t f2fs -o usrjquota= /dev/loop5 /mnt/f
> 
> Before this commit, the command succeeds. Afterwards, it fails with
> EINVAL and logs "f2fs: Bad value for 'usrjquota'".
> The same failure occurs when remounting to clear a quota file name.
> 
> This patch will restore fsparam_string_empty() for the three options
> while retaining the flag entries, so both forms are accepted.
> 
> Fixes: 2a3db1e02ce0 ("f2fs: allow empty mount string for Opt_usr|grp|projjquota")
> Cc: stable@vger.kernel.org # 7.1+
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
