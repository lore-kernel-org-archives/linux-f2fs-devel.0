From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [PATCH] f2fs-tools: avoid mounting f2fs if tools
 already open the device
Date: Tue, 10 Jul 2018 09:53:03 +0800
Message-ID: <16d09369-4776-d3d2-c8e1-0877a46e83e8@huawei.com>
References: <20180704095045.156157-1-shengyong1@huawei.com>
 <fef9843d-21f4-ade1-bfdf-1f2c4d3f1592@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fchqb-0000Fe-IY
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 01:53:45 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fchqZ-004jlu-Eu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 01:53:45 +0000
In-Reply-To: <fef9843d-21f4-ade1-bfdf-1f2c4d3f1592@kernel.org>
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
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi, Chao,

On 2018/7/9 23:14, Chao Yu wrote:
> On 2018/7/4 17:50, Sheng Yong wrote:
>> If the block device is opened by tools, F2FS should not be mounted.
>> Especially when fsck is running, errors unexpected may happen. So if
>> tools open a block device, we give it the O_EXCL flag to make sure
>> the block device is opened exclusivly.
> 
> Should we treat block inode and regular inode as the same?

I'm afraid not, the behavior of O_EXCL is not defined for regular inode
if it is used without O_CREAT. If f2fs is installed in a image file (not
a block device), we may still find a another way to avoid fsck and f2fs
run concurrently :(

thanks
> 
> Not sure about this, since for debuging, if we can't umount due to panic in
> f2fs, still we can dump last data in device.
> 
> Thanks,
> 
>>
>> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
>> ---
>>   lib/libf2fs.c | 27 +++++++++++++++++----------
>>   1 file changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
>> index b25fbf2..5625cff 100644
>> --- a/lib/libf2fs.c
>> +++ b/lib/libf2fs.c
>> @@ -783,21 +783,35 @@ int get_device_info(int i)
>>   #endif
>>   	struct device_info *dev = c.devices + i;
>>   
>> +	stat_buf = malloc(sizeof(struct stat));
>> +	ASSERT(stat_buf);
>> +	if (stat(dev->path, stat_buf) < 0 ) {
>> +		MSG(0, "\tError: Failed to get the device stat!\n");
>> +		free(stat_buf);
>> +		return -1;
>> +	}
>> +
>>   	if (c.sparse_mode) {
>> -		fd = open((char *)dev->path, O_RDWR | O_CREAT | O_BINARY, 0644);
>> +		fd = open(dev->path, O_RDWR | O_CREAT | O_BINARY, 0644);
>>   	} else {
>> -		fd = open((char *)dev->path, O_RDWR);
>> +		if (S_ISBLK(stat_buf->st_mode))
>> +			fd = open(dev->path, O_RDWR | O_EXCL);
>> +		else
>> +			fd = open(dev->path, O_RDWR);
>>   	}
>>   	if (fd < 0) {
>>   		MSG(0, "\tError: Failed to open the device!\n");
>> +		free(stat_buf);
>>   		return -1;
>>   	}
>>   
>>   	dev->fd = fd;
>>   
>>   	if (c.sparse_mode) {
>> -		if (f2fs_init_sparse_file())
>> +		if (f2fs_init_sparse_file()) {
>> +			free(stat_buf);
>>   			return -1;
>> +		}
>>   	}
>>   
>>   	if (c.kd == -1) {
>> @@ -810,13 +824,6 @@ int get_device_info(int i)
>>   		}
>>   	}
>>   
>> -	stat_buf = malloc(sizeof(struct stat));
>> -	if (fstat(fd, stat_buf) < 0 ) {
>> -		MSG(0, "\tError: Failed to get the device stat!\n");
>> -		free(stat_buf);
>> -		return -1;
>> -	}
>> -
>>   	if (c.sparse_mode) {
>>   		dev->total_sectors = c.device_size / dev->sector_size;
>>   	} else if (S_ISREG(stat_buf->st_mode)) {
>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
