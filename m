From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] generic: add a testcase to test uid/gid
 recovery
Date: Sat, 29 Sep 2018 13:59:47 +0800
Message-ID: <c92ea484-7dcc-9675-59d4-4f921daa5962@huawei.com>
References: <20180925084558.77190-1-yuchao0@huawei.com>
 <ab6235fd-ea62-59d4-246c-9b73bc3983f3@huawei.com>
 <20180928122823.GG17817@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1g68IO-00027V-R4
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Sep 2018 06:00:04 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g68IJ-00DuU2-Pc
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Sep 2018 06:00:04 +0000
In-Reply-To: <20180928122823.GG17817@desktop>
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
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/9/28 20:28, Eryu Guan wrote:
> On Tue, Sep 25, 2018 at 05:16:31PM +0800, Chao Yu wrote:
>> Hi Eryu,
>>
>> There are several fields in inode rather than uid/gid didn't recover in
>> f2fs, I'm not sure we need to cover all of them with one generic testcase,
>> or with several testcases. Any suggestion?
> 
> Sorry for the late response!
> 
> Several targeted test cases would be fine.

Okay, let me work on the others.

> 
> Thanks,
> Eryu
> 
> 
