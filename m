From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] add configure option --with-root-libdir
Date: Tue, 28 Aug 2018 11:43:39 +0800
Message-ID: <ea991c4f-8b41-1978-4fa6-2359edb30a1e@huawei.com>
References: <20180820030407.13225-1-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fuUv4-0006q8-2N
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 03:43:54 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fuUv2-000Xdn-27
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 03:43:54 +0000
In-Reply-To: <20180820030407.13225-1-tytso@mit.edu>
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
To: Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net

On 2018/8/20 11:04, Theodore Ts'o wrote:
> This allows the development link libraries to be installed in
> /usr/lib, while the run-libraries are installed in /lib, which is
> required by Debian policy.  This can be done via:
> 
>     configure --prefix=/ --libdir=/usr/lib --with-root-libdir=/lib
> 
> The technique of working around libtool's inflexibility is borrowed
> from util-linux.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
