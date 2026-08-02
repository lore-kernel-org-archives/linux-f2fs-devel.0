Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2B3C55171
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  2 Aug 2026 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8PKbc2CHgL1YPtcELMKwpi1c2xfgjSf12L7zQxvfQLE=; b=UHkuVE8naBOX9gcsMqpNoBx4pe
	ws69S+sCSOB+AoMRX9c45oVRtX0A7ujGs0BMalHTW06tExRCwVcOMYxtlmR91J1QElIMAvDb5fBzL
	xZFU+Hqx4PG05yWv9cDsE+ZwM2g+2KoX27Ev1Fp1fH70TG9r4BvBGufInK8S0+eqnHW8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqWBy-0006Aj-Km;
	Sun, 02 Aug 2026 13:25:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1wqWBy-0006Aa-3W
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 02 Aug 2026 13:25:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ft0Gl+O+Y3hvzCpKZZ6PTq7ZSvmTd2z/bSOeZuYNWsk=; b=LxGKkOkn1ghVCaFf7wk7QcJnpk
 2JZZJlSxXTfw7K1JBE84xmW2D0fkc/iqrUDfzK3c2zKAd5og8WZD+TULDXVwzm4xkP2f7O/3kd507
 RprGbj+Rtk2we/73PpbfoDBu3+LFw8aLlDbJIQOzcFtAoIl2SyqWQAg7RYgJveNiTneM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ft0Gl+O+Y3hvzCpKZZ6PTq7ZSvmTd2z/bSOeZuYNWsk=; b=Tw2GqiQa5ujf4EHhUjY+oYzI4d
 uUet9quYvRGHwjwbRqUsZZKiW6uXymy/3gwwawA0ya7qMsFIyyd0RmyZtUBIVqZ76BJ75iGHyfY3b
 IewN/r3jGoDW/j9qlwF4VvrcncQDT2XISQt0G6sCc0u6963LIM13dlJ833MKVhjjiNf8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqWC2-0001cc-00 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 02 Aug 2026 13:25:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 181EC43F1B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  2 Aug 2026 13:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFA81F000E9;
 Sun,  2 Aug 2026 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785677121;
 bh=ft0Gl+O+Y3hvzCpKZZ6PTq7ZSvmTd2z/bSOeZuYNWsk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=anBfds/128pgwodCvkTGm1LyIlyJzwC66Bq41ur7OI7rSUCBTukZYKq66ej1tsj1j
 0tBtDMZx9kc3myvY6xwx5mpU3+3Zl+3cFLUzGAl4gJHuJYAbFIbk+hp1vGQr5FN5Y4
 Aye6QBwbglMV8vkoEw2W51yaI5KzVHfbwKltFaiAUF0eEbTpp26KDq9SxG0ZRCZlXr
 Qk9w2d3hNn/1nUD/dL2K0BhaGyzPVurCaWUaGpnG46295j/O/XD0XFNYUWFx/iCxJV
 9qwcAelYMxAnJrSP8fnuDWweDB6jz8qTKD2kByKurkeXHybVXgOf1XqAI7NO70OlL6
 8B+Cvb0zeCnNw==
Date: Sun, 2 Aug 2026 21:25:14 +0800
To: Chao Yu <chao@kernel.org>
Message-ID: <am9FEmgp25SzUv-L@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 "Darrick J. Wong" <djwong@kernel.org>
References: <20260729094909.1499590-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260729094909.1499590-1-chao@kernel.org>
X-Headers-End: 1wqWC2-0001cc-00
Subject: Re: [f2fs-dev] [PATCH v3] common/rc: support f2fs in
 _require_fanotify_ioerrors()
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: jaegeuk@kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jul 29, 2026 at 09:49:09AM +0000, Chao Yu wrote:
> f2fs has supported to report fserror, this patch adds support for f2fs
> in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.
> 
> Cc: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - fix to chech sysfs node correctly

Thanks, let's have this at first.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/rc | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 106f044ad..3a8f03412 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6266,6 +6266,12 @@ _require_fanotify_ioerrors()
>  		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
>  		test -n "$x" && return 0
>  		;;
> +	f2fs)
> +		local feat_file="/sys/fs/f2fs/features/fserror"
> +		if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
> +			return 0
> +		fi
> +		;;
>  	esac
>  
>  	_notrun "$FSTYP does not support fanotify ioerrors"
> -- 
> 2.49.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
