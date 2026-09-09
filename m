Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2BAC79FAD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iJnnHq35vH+R49MJMnigiZICfltgXLAGIlf7kshnKR4=; b=l77qLdAGwg4s2lGiPsDEJ7kRTY
	SZqaA08b1u7QjsGR+mV1fSU38HZilwkZvqeQlAsATgz98CX1YTQCNZ3XShZCA5BH1EhdivRWBIt/6
	rQTcXkmREWL8BqKOYLHtxdbpii14WAhb+/WrirzYaBI0VcqU+QlAXWlUmULUjxhFv9hA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4H6S-0002oX-IO;
	Wed, 09 Sep 2026 12:08:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4H5t-0002nn-DW
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 12:07:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z/fyRKmyWcjAhwOrdKyi+6Pel+QX97RYxzmDXFW0tPc=; b=ljOmIoCh1KCKFuGBDmwtHubRc9
 2GC8ObwIT3E71JFSBwtiCI7NBc9mcw3UszEA8gtwLH6jgP6HUW7+Kq7FmsKIeDakAMQo6qlEmNz08
 5uNVMVS3krKSMaCIPiRn1FL9kyDx+tJ1sWPlLaeuUslHcgSNxZw9zNIzJ1x9jVCZ3reg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=z/fyRKmyWcjAhwOrdKyi+6Pel+QX97RYxzmDXFW0tPc=; b=IfmkhLQ/eDGfCHQfTT+WzMTgUF
 OFrHvT8b300Gbu7vcRPpK0iHgMIkLdbUiMQaWso3JX7KDc5hQ2WvxcoJrPi+qpDUcgtSbGBTTPbV7
 nBgb71U8/0650L3VrtG2vKxZzECJRCXU2t+ByWUmslt99xan8hjb+dgmZjvqWLsFbo/Q=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4H5q-0008Hs-Gm for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 12:07:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D493960214;
 Wed,  9 Sep 2026 12:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA94D1F00A3E;
 Wed,  9 Sep 2026 12:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788955672;
 bh=z/fyRKmyWcjAhwOrdKyi+6Pel+QX97RYxzmDXFW0tPc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=UI5bUd8HaWIOk25Bl+Av+AxC/Fq084xI0Po20OP0roome+yL74YYYGHxEaB/KgxSZ
 7z+6uYu7LeVLDRuCu311E1arra2i1k1GS97kfSykwE1T+mvERlpZPuyB5EZTeRWicq
 U3zAtVlqLsLghub+nvEPcJ+tVEk+vQW4kihUfc39GDBpRgTDB/PziofSP6mLJXf09e
 V2XTiucNRRM/1fCSVnklqOmk+FUwY9n9tdC/Vn/Ryepr/EXDWfQveAbtCDzs6vbNGN
 2svwVq3uhIq3UCjzt09IIZzITUfGsrndc9JoG/HrBIkFKtziEiQ6gNOr3WbzQOF/Yl
 y9uaFlFN+OIMw==
Message-ID: <3a22ec95-18a6-4f92-8bc2-80f13bc7de32@kernel.org>
Date: Wed, 9 Sep 2026 20:07:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jianan Huang <jnhuang95@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
References: <20260909114615.1390443-1-jnhuang95@gmail.com>
Content-Language: en-US
In-Reply-To: <20260909114615.1390443-1-jnhuang95@gmail.com>
X-Headers-End: 1x4H5q-0008Hs-Gm
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: quota: fix stale lock holder on
 remount failure
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/9/26 19:46, Jianan Huang wrote:
> F2FS remount can fail while duplicating a journalled quota file name.
> 
> f2fs_remount()
> - sbi->umount_lock_holder = current
> - kstrdup(F2FS_OPTION(sbi).s_qf_names[i])
>   : fails
> - free previously duplicated names
> - return -ENOMEM
> 
> The direct return leaves umount_lock_holder pointing at the failed
> remount context.  A later checkpoint may then wrongly treat another
> context as the s_umount lock holder.
> 
> Add a restore_holder cleanup path and use it before returning -ENOMEM.
> 
> Fixes: eb85c2410d6f ("f2fs: quota: fix to avoid warning in dquot_writeback_dquots()")
> Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
