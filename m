From: Chao Yu <chao@kernel.org>
Subject: Re: mount fail with option fault_injection < 20000 && >0
Date: Tue, 18 Sep 2018 20:21:28 +0800
Message-ID: <fa4fccef-e9d5-50be-dd29-d1f531f2ddf4@kernel.org>
References: <61afbde5-f05e-9bd5-8dc2-31932c13cd51@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1g2F0k-0001OL-5K
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Sep 2018 12:21:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g2F0i-00ErEn-3a
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Sep 2018 12:21:45 +0000
In-Reply-To: <61afbde5-f05e-9bd5-8dc2-31932c13cd51@gmx.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: cgxu519 <cgxu519@gmx.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

Hi Chengguang,

On 2018/9/18 19:02, cgxu519 wrote:
> HI guys,
> 
> I found mount with option fault_injection < 20000 && >0 will fail with error
> -ENOMEM.
> I understand fault_injection function is explicitly mocking some errors, but

If we skip injecting error into memory allocation functions during mount, we may
miss checking most error paths in fill_super(). So I think we really need this
during mount.

But if you want to inject error after mount, you can reenable error injection by
configuring fault_injection/fault_rate sysfs entry.

Thanks,

> isn't it better
> mocking errors after successful mount? Is it really allocating memory so many times
> during mount process?
> 
> Thanks,
> Chengguang
> 
> 
> 
> 
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
