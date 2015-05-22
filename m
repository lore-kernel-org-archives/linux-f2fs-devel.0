From: hujianyang <hujianyang@huawei.com>
Subject: Re: [PATCH RFC] f2fs: recovering broken superblock
	during mount
Date: Fri, 22 May 2015 08:19:59 +0800
Message-ID: <555E762F.6090007@huawei.com>
References: <555C3130.9010205@huawei.com>
	<20150521010635.GA63442@jaegeuk-mac02.mot.com>
	<555D7E6D.2050103@huawei.com>
	<20150521224414.GA71279@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hujianyang@huawei.com>) id 1YvahI-0002nR-R9
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 May 2015 00:20:20 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YvahF-0003fq-S5
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 May 2015 00:20:20 +0000
In-Reply-To: <20150521224414.GA71279@jaegeuk-mac02>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2015/5/22 6:44, Jaegeuk Kim wrote:
> Hi Hu,
> 
> Looks good to me, except one minor thing where 
> 
> +	int recovery = 0, i;
>  -> AFAIK, kernel coding style recommends to split them.
>  Let me change that to
> 
>  	int recovery = 0;
> 	int i;
> 
> 
> Merged.
> 
> Thanks,

Hi Jaegeuk,

Thank you!:)

Hu



------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
